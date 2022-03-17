variable "ebs_app_name"{
    type    =   string
    description     =   "name of the application"
}

# variable "env_name"{
#     type    =   string
#     description     =   "name of the application"
# }

variable "solution_stack_name"{
    type    =   string
    description     =   "Environment for the application"
}

variable "vpc_id" {
    type = string
    description = "vpc id of the infrastructure"

}
variable "subnet_id" {
    type = string
    description = "subnet id of the infrastructure"
}

variable "cname_prefix" {
    type = string
    description = "cname of the application"
}

variable "instance_type" {
    type = string
    description = "server type of the application"
}

variable "bucket" {
    type = string
    description = "zip file of the code will upload in s3 bucket"
}

variable "key" {
    type = string
    description = "key (object) of the s3 bucket"
}

variable "app_version_name" {
    type = string
    description = "application version of the app"
}
