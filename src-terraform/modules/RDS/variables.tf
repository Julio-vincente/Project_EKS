variable "private_subnets_ids" {
  description = "subnets_ids"
  type        = list(string)
}

variable "public_subnets_ids" {
  description = "subnets_ids"
  type        = list(string)
}

variable "security_group_rds" {
  description = "Sg_Rds"
  type        = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "parameter_group_name" {
  type    = string
  default = "default.mysql8.0"
}

variable "subnet_group_name" {
  type    = string
  default = "subnet1"
}
