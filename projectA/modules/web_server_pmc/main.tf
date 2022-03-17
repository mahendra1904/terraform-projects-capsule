# resource to create a ec2
resource "aws_instance" "server_pmcA"{
         
         ami   =   data.aws_ami.amzlinux.id
         instance_type  =   "${var.instance_type}"
         availability_zone  =   "${var.az}"
         key_name           =   "feb"
         count = terraform.workspace == "default" ? 1 : 0 
         user_data = file("F:/GIIT/terraform-project-capsule/projectA/modules/web_server_pmc/apache.sh")  
         tags = {
            "Name" = "pmc-${terraform.workspace}-${count.index}"
        }

    
}


