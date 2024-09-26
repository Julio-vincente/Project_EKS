output "public_subnets_ids" {
  description = "ID das subnets Publicas"
  value       = [aws_subnet.subnet_production_pub_1a.id, aws_subnet.subnet_production_pub_1b.id]
}

output "private_subnets_ids" {
  description = "ID das subnets Privadas"
  value       = [aws_subnet.subnet_production_priv_1a.id, aws_subnet.subnet_production_priv_1b.id]
}

output "sg_rds" {
  description = "Id do Security Group Rds"
  value       = aws_security_group.RDS_SG.id
}
