output "rds_username" {
  value = jsondecode(aws_secretsmanager_secret_version.rds_password_secret_version.secret_string)["username"]
}

output "rds_password" {
  value = jsondecode(aws_secretsmanager_secret_version.rds_password_secret_version.secret_string)["password"]
}
