resource "aws_s3_bucket" "bucket_rds" {
  bucket = var.name_s3

  tags = {
    Name       = "S3 RDS Data"
    enviroment = "Production"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket_rds.id

  block_public_policy     = false
  block_public_acls       = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}