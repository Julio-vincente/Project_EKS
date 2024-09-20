# variables.tf
variable "Metric-Name" {
  type    = string
  default = "Cpu Usage"
}

variable "Dash-Name" {
  type    = string
  default = "DashBoard-Eks"
}

variable "ebs_volume_id" {
  type = string
}
