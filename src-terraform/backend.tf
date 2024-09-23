provider "aws" {
  region = var.aws_region
}

module "VPC" {
  source = "./modules/VPC"
}

module "WAF" {
  source     = "./modules/WAF"
  depends_on = [ module.VPC ]
}

module "EBS" {
  source = "./modules/EBS"
}

module "Cloud_Watch" {
  source = "./modules/Cloud_Watch"

  Dash_Name     = "DashBoardForEKS"
  depends_on    = [module.EBS]
  ebs_volume_id = module.EBS.ebs_volume_id[0]
  Metric_Name   = "CPU/Storage Utilization"
}

module "ECR" {
  source = "./modules/ECR"
}

