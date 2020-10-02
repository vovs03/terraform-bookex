provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "simple-web-server" {
  # Amazon Linux 2 AMI (HVM), SSD Volume Type 
  ami                    = "ami-00a205cb8e06c3c4e"
  instance_type          = "t2.nano"

  user_data = <<-EOF
            #!/bin/bash
            echo "Simple server runned by Vladimir Pavlychev at AWS ::EU from Protvino(Moscow,Russia)" > index.html
            nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "Terraform-web"
  }
}

resource "aws_security_group" "instance"{
  name = "terraform-example-instance"

  ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}