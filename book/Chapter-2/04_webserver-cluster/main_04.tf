terraform {
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs
  # For Terraform ~> v.0.13.4
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  # Frankfurt
  region = "eu-central-1"
}

# Конфигурация запуска
resource "aws_launch_configuration" "launch_conf" {
  #Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-092391a11f8aa4b7b (64-bit x86)
  image_id        = "ami-092391a11f8aa4b7b"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
            #!/bin/bash
            echo "Cluster_web_server runned by Vladimir Pavlychev at AWS ::EU from Protvino(Moscow,Russia)" > index.html
            nohup busybox httpd -f -p ${var.server_port} &
              EOF
  
  # Требуетсяпри использовании автоскейлинг гроуп
  # в конфигурации запуска
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.launch_conf.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  # 6. (integration ASG & ALB)
  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"
  # /6.

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance"{
  name = "terraform-example-instance"

  ingress {
      from_port   = var.server_port
      to_port     = var.server_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_lb" "example" {
  name = "terraform-asg-example"
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.default.ids
  # 4.04 
  security_groups    = [aws_security_group.alb.id]
}

# 04.2 определение прослушивателя
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
} # /4.02

# 4.05 new group ASG
resource "aws_lb_target_group" "asg" {

  name = var.alb_name

  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
} # /4.05

# 4.03 новая группа безопасности специально для балансировщика нагрузки
resource "aws_security_group" "alb" {

  name = var.alb_security_group_name

  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} # /4.03
