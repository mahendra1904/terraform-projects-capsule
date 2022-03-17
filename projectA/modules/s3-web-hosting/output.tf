# output variables to access the web details of the endpoins, bucket arn ...etc

 output "web_url" {
     value = "${aws_s3_bucket.bucket.website_endpoint}"
 }

 output "s3-bucket-arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}

output "bucket-domain" {
    description = "domain name of the aws web s3 bucket"
    value = "${aws_s3_bucket.bucket.website_domain}"
}

output "bucket-endpoint" {
    description = "Endpoint Information of the web bucket" 
    value = "${aws_s3_bucket.bucket.website_endpoint}"
}