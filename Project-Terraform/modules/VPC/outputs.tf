output "VPC-Id" {
  description = "Id VPC Production"
  value = aws_vpc.vpc-production.id
}

output "Subnet Private 1a" {
  description = "ID Private Subnet Region A"
  value = aws_subnet.subnet_production_priv_1a.id
}

output "Subnet Private 1b" {
  description = "ID Private Subnet Region B"
  value = aws_subnet.subnet_production_priv_1b.id
}