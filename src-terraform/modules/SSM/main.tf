resource "aws_secretsmanager_secret" "rds_password_secret" {
  name = var.name_secret

  description = var.description_ssm
}

resource "aws_secretsmanager_secret_version" "rds_password_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_password_secret.id
  secret_string = jsonencode({

    username = "admin"
    password = "Senai@134"
  })
}