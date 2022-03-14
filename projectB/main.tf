
provider "aws" {
  region = "us-east-1"
}

# module "vpc-pmc" {
#   source       = "./modules/vpc"
#   vpc_cidr     = "10.0.0.0/20"
#   public_cidr  = "10.0.0.0/24"
#   private_cidr = "10.0.1.0/24"
#   public_az    = "us-east-1a"
#   private_az   = "us-east-1b"

# }


# module "s3-dynamodb-lambda" {
#   source = "./modules/s3-lambda-dynamodb"
#   bucket-name       = "giit-dymanodb-pmc"
#   name           = "pmc-tableA"
#   hash_key       = "unique"
#   read_capacity  = 20
#   write_capacity = 20  
# }

module "ebs-app"{
  source   =   "./modules/ebs"
  ebs_app_name    =   "nodejs-application"
  env_name  = "node-app-env"
  #solution_stack_name = "64bit Amazon Linux 2015.03 v2.0.3 running Go 1.4"  
  solution_stack_name   = "64bit Amazon Linux 2 v5.5.0 running Node.js 16"

}






















