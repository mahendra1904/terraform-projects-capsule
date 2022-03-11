
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.s3_bucket_name[count.index]}"
  count  = length("${var.s3_bucket_name}")
  
  #region = "${var.region}"
#   acl    = "${var.acl}"

#   versioning {
#     enabled = "${var.versioning-enable}"
#   }
#   lifecycle {
#     prevent_destroy = false
#   }
  tags = {
    Name = "${var.s3_bucket_name[count.index]}"
  }
}
