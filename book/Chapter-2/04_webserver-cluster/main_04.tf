terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "cluster_web_server" {
  #Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-092391a11f8aa4b7b (64-bit x86)
  ami = "ami-092391a11f8aa4b7b"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
            #!/bin/bash
            echo "Cluster_web_server runned by Vladimir Pavlychev at AWS ::EU from Protvino(Moscow,Russia)" > index.html
            nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    Name = "Terraform-configured-web"
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