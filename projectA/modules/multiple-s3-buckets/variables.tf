# this varibale is list type so that multiple s3 bucket can be created
variable "s3_bucket_name" {
    type    =   list
    description     =   "create multiple s3 bucket"
}

# variable "acl"{
#     type    =   string
#     description =   "access contrl list of the aws s3 bucket"
# }

# variable "versioning-enable" {
#     type = string
#     description = "Enable the version of the s3 bucket"
# }
