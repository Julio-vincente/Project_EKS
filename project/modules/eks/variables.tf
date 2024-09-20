variable "cluster_name" {
  type = string
  default = "eks-Production"
}

variable "nodes_name" {
    type = string
    default = "Node-production"
}

variable "service_role_arn" {
    type = string
    default = "arn:aws:iam::492180519342:role/LabRole"
}

variable "instance_role_arn" {
  type = string
  default = "arn:aws:iam::492180519342:instance-profile/LabInstanceProfile"
}