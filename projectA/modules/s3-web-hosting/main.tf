
# create s3 bucket to host the static web site
resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket-name}"
      policy = <<POLICY # s3 bucket inline policy to access the bucket publically
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicReadGetObject",
      "Effect":"Allow",
      "Principal":"*",
      "Action":"S3:GetObject",
      "Resource":"arn:aws:s3:::${var.bucket-name}/*"
    }
  ]
}
POLICY  # enable the bucket for static web hosting
    website   {
       index_document    =   "index.html"
       
   }
  tags  =   {
      Name  =   "web"
      Environment   =   "Dev"
  }
}

# resource "aws_s3_bucket_policy" "public_access" {
#   bucket = "${aws_s3_bucket.bucket.id}"
#   policy = data.aws_iam_policy_document.allow_public_access.json
# }

# data "aws_iam_policy_document" "allow_public_access" {
#  statement {
#     principals  {
#         type    =   "AWS"
#         identifiers    =   ["*"]
#     }
#     sid = "PublicReadGetObject"
#     effect = "Allow"
#     actions = [
#       "s3:GetObject"
#     ]
#     resources = [
#       #"arn:aws:s3:::${aws_s3_bucket.bucket.arn}/*"
#       "${aws_s3_bucket.bucket.arn}/*"
#     ]
#   }
# }


# resource "aws_s3_bucket_object" "web_page"{
#     for_each    =   fileset(path.module, "**/*.html")
#     bucket =    "${aws_s3_bucket.bucket.id}"
#     key =   each.value
#     #source  =   "F:/GIIT/terraform-project-capsule/projectA/modules/s3-web-hosting/index.html"
#     source  =   "${path.module}/${each.value}"
    
# }

# this resource type has came in new version of aws provider (~>4)
# resource "aws_s3_bucket_website_configuration" "pmc-web"{

#   bucket  = "${aws_s3_bucket.bucket.bucket}"
#   index_document {
#     suffix  = "index.html"
#   }
#   error_document{
#     key = "error.html"
#   }  
# }#


#to upload a single file
resource "aws_s3_bucket_object" "web_page"{
    bucket =    "${aws_s3_bucket.bucket.id}"
    key =   "index.html"
    source  =   "F:/GIIT/terraform-project-capsule/projectA/modules/s3-web-hosting/index.html"
}


# to upload the multiple file(objects) in aws s3 bucket
# resource "aws_s3_bucket_object" "web_page" {
#   for_each = fileset("./documents/", "*")
#   bucket = "${aws_s3_bucket.bucket}"
#   key = each.value
#   source = "./documents/${each.value}"
#   etag = filemd5("./documents/${each.value}")
# }
