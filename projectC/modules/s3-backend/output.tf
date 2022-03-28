# aws s3 bucket name
output "artifact_bucket_name" {
    value = aws_s3_bucket.artifact.bucket
  
}

