
output "bucket_name" {
    value = aws_s3_bucket.sftp_server_bucket.bucket

  
}

output "bucket_arn" {
    value = aws_s3_bucket.sftp_server_bucket.arn
  
}

output "bucket_id" {
    value = aws_s3_bucket.sftp_server_bucket.id
  
}
