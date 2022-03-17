# all the variables for the block

variable "instance_type" {
    type = string
    description = "type of the instance-type"
}

variable "key_name" {
    type = string
    description = "key to ssh for thne instance"
}

variable "public_subnet_id" {
    type = string
    description = "public subnet for the instance"
}

variable "private_subnet_id" {
    type = string
    description = " private subnet for the instance"
}
variable "security_groups" {
    type = list(string)
    description = "attached the security groups for the web server"
}

