module "ebs" {
  source = "./modules/EBS"
}

module "cloudwatch" {
  source        = "./modules/Cloud_Watch"
  ebs_volume_id = module.ebs.VolumeId
}
