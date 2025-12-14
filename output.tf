output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
output "alb_dns" {
  value = aws_lb.app_alb.dns_name
}

output "ec2_public_ip" {
  value = aws_instance.backend.public_ip
}
output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
