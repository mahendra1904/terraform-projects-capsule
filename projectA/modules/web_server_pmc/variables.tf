
variable "ami" {
    type = string
    description = "ami_id for web-server "
}

variable "instance_type"{
    type    =   string
    description     =   "server type of ec2 instance"
}

# variable "subnet_id"{
#     type =  string
#     description     =   "subner id of web server"
# }

variable "az"{
    type    =   string
    description = "web server az"
}