variable "name_http" {
    type = string
    description =   "security group for the web server"
}

variable "name_ssh" {
    type = string
    description =   "security group for the ssh"
}


variable "vpc_id" {
    type = string
    description = "aws vpc id"
}

variable "from_port_ingress_http" {
    type = string
    description = " starting port number for ingress"

}

variable "to_port_ingress_http" {
    type = string
    description = "ending port number for ingress"
}

variable "protocol_ingress_http" {
    type = string
    description = "protocol_ingress"
}

variable "from_port_egress_http" {
    type = string
    description = " starting port number for ingress"

}

variable "to_port_egress_http" {
    type = string
    description = "ending port number for ingress"
}

variable "protocol_egress_http" {
    type = string
    description = "protocol_ingress"
}

variable "cidr_blocks_ingress_http" {
    type = list(string)
    description = "cide block of ingress rule"
}

variable "cidr_blocks_egress_http" {
    type = list(string)
    description = "cide block of egress rule"
}

variable "from_port_ingress_ssh" {
    type = string
    description = " starting port number for ingress"

}

variable "to_port_ingress_ssh" {
    type = string
    description = "ending port number for ingress"
}

variable "protocol_ingress_ssh" {
    type = string
    description = "protocol_ingress"
}

variable "from_port_egress_ssh" {
    type = string
    description = " starting port number for ingress"

}

variable "to_port_egress_ssh" {
    type = string
    description = "ending port number for ingress"
}

variable "protocol_egress_ssh" {
    type = string
    description = "protocol_ingress"
}

variable "cidr_blocks_ingress_ssh" {
    type = list(string)
    description = "cide block of ingress rule"
}

variable "cidr_blocks_egress_ssh" {
    type = list(string)
    description = "cide block of egress rule"
}
