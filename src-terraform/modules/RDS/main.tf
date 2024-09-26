resource "aws_db_instance" "name" {
  allocated_storage    = 20
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = var.parameter_group_name
  publicly_accessible  = true
  skip_final_snapshot  = true

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  vpc_security_group_ids = var.private_subnets_ids
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = var.subnet_group_name

  subnet_ids = var.public_subnets_ids
}
