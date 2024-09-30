variable "ssm_name" {
  type    = string
  default = "rds_secrets_databases"
}

variable "ssm_description" {
  type    = string
  default = "RDS_username_and_password"
}
