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

  tags = {
    #Name = "Terraform-"
  }
}

resource ""

resource "aws_security_group" "instance"{
  name = "terraform-example-instance"

  ingress {
      from_port   = var.server_port
      to_port     = var.server_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}