resource "aws_s3_bucket" "bucket_rds" {
    bucket = "rds_data${var.name_s3}"

    tags = {
      Name = "S3 RDS Data"
      enviroment = "Production"
    }
}