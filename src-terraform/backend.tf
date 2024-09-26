provider "aws" {
  region = var.aws_region
}

module "VPC" {
  source = "./modules/VPC"
}

module "EKS" {
  source             = "./modules/EKS"
  public_subnets_ids = module.VPC.public_subnets_ids
  depends_on         = [module.VPC]
}

module "WAF" {
  source     = "./modules/WAF"
  depends_on = [module.VPC]
}

module "SSM" {
  source = "./modules/SSM"
}

module "RDS" {
  source              = "./modules/RDS"
  private_subnets_ids = module.VPC.private_subnets_ids
  public_subnets_ids  = module.VPC.public_subnets_ids
  rds_password        = module.SSM.rds_password
  rds_username        = module.SSM.rds_username
  security_group_rds  = module.VPC.sg_rds
  depends_on          = [module.VPC, module.SSM]
}

module "EBS" {
  source = "./modules/EBS"
}

module "Cloud_Watch" {
  source        = "./modules/Cloud_Watch"
  Dash_Name     = "DashBoardForEKS"
  depends_on    = [module.EBS]
  ebs_volume_id = module.EBS.ebs_volume_id[0]
  Metric_Name   = "CPU/Storage Utilization"
}

module "ECR" {
  source = "./modules/ECR"
}

module "S3" {
  source = "./modules/S3" 
}