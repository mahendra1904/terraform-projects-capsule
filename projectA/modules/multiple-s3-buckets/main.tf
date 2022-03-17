
# resource to create a multiple s3 bucket 
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.s3_bucket_name[count.index]}"  
  count  = length("${var.s3_bucket_name}") # this variable should be a list type for multiple s3 buckets
  
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
