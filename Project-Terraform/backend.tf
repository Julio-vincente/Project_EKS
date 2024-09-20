provider "aws" {
  region = var.aws_region
}

module "VPC" {
  source = "./modules/VPC"
}

module "WAF" {
  source = "./modules/WAF"
  depends_on = [ module.VPC ]
}

module "EBS" {
  source = "./modules/EBS"  
}

module "Cloud_Watch" {
  source = "./modules/Cloud_Watch"
  Dash-Name = aws_cloudwatch_dashboard
  depends_on = [ module.EBS ]
}

module "ECR" {
  source = "./modules/ECR"
}