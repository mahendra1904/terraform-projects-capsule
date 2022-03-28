resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  versioning   {
      enabled =     true

  }
  tags = {
    Name = "${var.bucket_name}"
  }
}


resource "aws_s3_bucket" "artifact" {
    bucket = var.artifact_bucket
    versioning {
        enabled = true
    }
    tags = {
      "Name" = var.artifact_bucket
    }
  
}