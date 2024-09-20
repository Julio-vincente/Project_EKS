# variables.tf
variable "Metric_Name" {
  description = "Name of the metric for the alarm"
  type        = string
}

variable "Dash_Name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
}

variable "ebs_volume_id" {
  type = string
}