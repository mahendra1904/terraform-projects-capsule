provider "aws" {
  region = "us-east-1"
}

# module to create a web_server (that is a ec2_instance)
module "web_server" {

    source  =   "./modules/web_server_pmc"
    ami  =   "ami-0c293f3f676ec4f90"
    instance_type   =   "t2.micro"
    az  =   "us-east-1a"
}

# module to create a s3 bucket
module "s3" {
  source = "./modules/s3"
  bucket-name       = "pmc-giit-storage"

}

# module to create multiple s3 buckets
module "multiple-s3" {
   source = "./modules/multiple-s3-buckets"
   s3_bucket_name       = ["pmc-giit-1","pmc-giit-2","pmc-giit-3"]

 }

# module to create a dynamodb table
module "dynamodb-table" {
  source         = "./modules/dynamodb"
  name           = "pmc-tableA"
  hash_key       = "id"
  read_capacity  = 20
  write_capacity = 20

}


# module to create a iam role
module "iam-role"{
  source  = "./modules/iam" 
}

# module to create s3 web hosting
module "static-web-hosting" {

  source      = "./modules/s3-web-hosting"
  bucket-name = "pmc-tech-art-pvt"
  #key         = "web"

}












