output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.main.id
}

output "management_subnet_id" {
  description = "Management subnet id (public)"
  value       = [for s in aws_subnet.management : s.id]
}

output "app_subnet_ids" {
  description = "Application subnet ids (private)"
  value       = [for s in aws_subnet.app : s.id]
}

output "backend_subnet_ids" {
  description = "Backend subnet ids (private)"
  value       = aws_subnet.backend.id
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = aws_lb.app_alb.dns_name
}
