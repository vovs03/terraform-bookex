output "public_ip" {
  value       = aws_instance.configured_web_server.public_ip
  description = "The public IP-address of the configuring-web-server"
}

