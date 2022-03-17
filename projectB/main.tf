# terraform aws provider
provider "aws" {
  region = "us-east-1"
}

# vpc module 
module "vpc-pmc" {
  source       = "./modules/vpc"
  vpc_cidr     = "10.0.0.0/20"
  public_cidr  = "10.0.0.0/24"
  private_cidr = "10.0.1.0/24"
  public_az    = "us-east-1a"
  private_az   = "us-east-1b"

}

# module to create s3 bucket, dynamodb and lamda function 
module "s3-dynamodb-lambda" {
  source = "./modules/s3-lambda-dynamodb"
  bucket-name       = "giit-dymanodb-pmc"
  name           = "pmc-tableA"
  hash_key       = "unique" # hash_key is the primary key for the dynamodb
  read_capacity  = 20 # read_capacity for dynamodb table 
  write_capacity = 20 # wrire_capacity for dynamodb table
}

# aws provided code deployment in ebs
module "ebs-app"{
  source   =   "./modules/ebs"
  ebs_app_name    =   "nodejs-application" # application name
  env_name  = "node-app-env" # environment name for the application
  #solution_stack_name = "64bit Amazon Linux 2015.03 v2.0.3 running Go 1.4"  
  solution_stack_name   = "64bit Amazon Linux 2 v5.5.0 running Node.js 16"  # it will be the plateform for the application in which your app will run like java,nodeja,.net,go..etc
  vpc_id    = module.vpc-pmc.vpc_id # module.<MODULE_NAME>.<OUTPUT_NAME>
#   module.<MODULE_NAME>.<OUTPUT_NAME>
  subnet_id = module.vpc-pmc.public_subnet_id
  cname_prefix  = "pmc-giit-pvt"   # domain name for the application
  instance_type = "t2.micro"   # type of the server.
}

  #module.<MODULE_NAME>.<OUTPUT_NAME>

# module for app deployment in ebs and code is in s3
module "ebs-s3-app"{
  source   =   "./modules/ebs-s3"
  ebs_app_name    =   "nodejs-application"
  solution_stack_name   = "64bit Amazon Linux 2 v5.5.0 running Node.js 16"
  vpc_id    = module.vpc-pmc.vpc_id  # to pass the value from different module the syntax is module.<MODULE_NAME>.<OUTPUT_NAME>

#   module.<MODULE_NAME>.<OUTPUT_NAME>
  subnet_id = module.vpc-pmc.public_subnet_id
  cname_prefix  = "pmc-giit-pvt-ltd"  # domain name for the app
  instance_type = "t2.micro"
  bucket  = "web-pmc-giitweb" # bucket name
  key   =   "nodeAppCustomecodeEBS.zip" # object name is the key name
  app_version_name = "v1" # version of the app

}

# module to create the security group
module "sgs"{
  source  = "./modules/security_group"
  name_http  = "enable_http"
  name_ssh  = "enable_ssh"
  vpc_id  = module.vpc-pmc.vpc_id  # it take value form different module
  cidr_blocks_ingress_http = ["0.0.0.0/0"]
  from_port_ingress_http = "80"
  to_port_ingress_http = "80"
  protocol_ingress_http  = "tcp"
  cidr_blocks_egress_http = ["0.0.0.0/0"]
  from_port_egress_http = "0"
  to_port_egress_http = "0"
  protocol_egress_http  = "-1"
   cidr_blocks_ingress_ssh = ["0.0.0.0/0"]
  from_port_ingress_ssh = "22"
  to_port_ingress_ssh = "22"
  protocol_ingress_ssh  = "tcp"
  cidr_blocks_egress_ssh = ["0.0.0.0/0"]
  from_port_egress_ssh = "0"
  to_port_egress_ssh = "0"
  protocol_egress_ssh  = "-1"
}


# module to create the public and private ec2
module "servers" {
  source = "./modules/infrastructure"
  public_subnet_id= module.vpc-pmc.public_subnet_id
  instance_type = "t2.micro"
  key_name  = "feb"  # key for ssh the ec2
  private_subnet_id= module.vpc-pmc.private_subnet_id
  security_groups = [module.sgs.web_sg,module.sgs.ssh_sg] # attached two security group
  ##   module.<MODULE_NAME>.<OUTPUT_NAME>
}



















