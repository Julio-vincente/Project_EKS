resource "aws_secretsmanager_secret" "example" {
  name = var.secret_name
  description = var.description_secret_manager
}

resource "aws_secretsmanager_secret_version" "Version-SM" {
  secret_id = aws_secretsmanager_secret.example.id
  secret_string = var.User_Password 
}