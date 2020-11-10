# 4.08
output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "ELB DomainName (Ch-2 04_webserver_cluster)"
}# /4.08