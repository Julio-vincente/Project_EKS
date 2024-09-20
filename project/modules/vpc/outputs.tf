output "vpc_id" {
  description = "ID da Vpc Production"
  value = aws_vpc.vpc-production.id
}

output "subnet_production_1a" {
  description = "ARN da production subnet1a"
  value = aws_subnet.subnet-production-1a.arn
}

output "subnet_production_1b" {
  description = "ARN da production subnet1b"
  value = aws_subnet.subnet-production-1b.arn
}