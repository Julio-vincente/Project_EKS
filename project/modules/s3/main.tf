resource "aws_s3_bucket" "bucket_rds" {
    bucket = var.name_s3 
}