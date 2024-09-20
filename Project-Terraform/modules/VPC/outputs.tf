output "VPC_Id" {
  description = "Id VPC Production"
  value = aws_vpc.vpc-production.id
}

output "Subnet_Private_1a" {
  description = "ID Private Subnet Region A"
  value = aws_subnet.subnet_production_priv_1a.id
}

output "Subnet_Private_1b" {
  description = "ID Private Subnet Region B"
  value = aws_subnet.subnet_production_priv_1b.id
}