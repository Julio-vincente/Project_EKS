resource "aws_db_instance" "rds-production" {
    allocated_storage = 10
    db_name = var.db_name
    engine = "mysql"
    engine_version = "~> 8.0"
    instance_class = var.instance_class
    username = var.db_user_name
    password = var.db_password
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
}