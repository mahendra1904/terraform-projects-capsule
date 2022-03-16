resource "aws_security_group" "web_http"{
     name   =   var.name_http
     vpc_id =   var.vpc_id
     ingress{
         cidr_blocks    =   var.cidr_blocks_ingress_http
         from_port  =   var.from_port_ingress_http
         to_port    =   var.to_port_ingress_http
         protocol   =   var.protocol_ingress_http

     }
     egress{
         cidr_blocks    =   var.cidr_blocks_egress_http
         from_port  =   var.from_port_egress_http
         to_port    =   var.to_port_egress_http
         protocol   =   var.protocol_egress_http
     }
}

resource "aws_security_group" "ssh"{
     name   =   var.name_ssh
     vpc_id =   var.vpc_id
     ingress{
         cidr_blocks    =   var.cidr_blocks_ingress_ssh
         from_port  =   var.from_port_ingress_ssh
         to_port    =   var.to_port_ingress_ssh
         protocol   =   var.protocol_ingress_ssh

     }
     egress{
         cidr_blocks    =   var.cidr_blocks_egress_ssh
         from_port  =   var.from_port_egress_ssh
         to_port    =   var.to_port_egress_ssh
         protocol   =   var.protocol_egress_ssh
     }
}

