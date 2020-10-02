provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "example" {
  # Amazon Linux 2 AMI (HVM), SSD Volume Type 
  ami           = "ami-00a205cb8e06c3c4e"
  instance_type = "t2.nano"
  tags = {
    Name = "Terraform-example"
}
}