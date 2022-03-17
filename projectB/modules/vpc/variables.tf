
# all the variables in this file

variable "vpc_cidr"{
    type    =   string
    description     =   "cidr block for the vpc"

}

variable "public_cidr" {
    type = string
    description = "public cide block"
}


variable "private_cidr" {
    type = string
    description = "private cide block"
}

variable "public_az" {
    type = string
    description = "subnet of a public availability zone"
}

variable "private_az" {
    type = string
    description = "subnet of a private availability zone"
}
