provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "waf" {
  source = "./modules/waf"
  depends_on = [ module.vpc ]
}

module "Cloud_Watch" {
  source = "./modules/Cloud_Watch"
}

module "ecr" {
  source = "./modules/ecr"
}