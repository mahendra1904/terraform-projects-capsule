# resource to create the ec2 for public access
resource "aws_instance" "public_server"{
    ami =   data.aws_ami.amzlinux.id # Amazon Machine Image for ec2
    instance_type   =   var.instance_type
    key_name    =   var.key_name
    vpc_security_group_ids  =   var.security_groups  
    #security_groups =var.security_groups
    subnet_id   =   var.public_subnet_id
    #for_each = toset(["one", "two", "three"])
    # user data to install the https n ec2 machine
    user_data = file("F:/GIIT/terraform-project-capsule/projectB/modules/infrastructure/apache_install.sh")
    tags    =   {
        Env     =   "dev"
        server  =   "public"
    }

}

# resource to create the ec2 for private
resource "aws_instance" "private_server"{
    ami =   data.aws_ami.amzlinux.id
    instance_type   =   var.instance_type
    key_name    =   var.key_name
    vpc_security_group_ids  =   var.security_groups  
    subnet_id   =   var.private_subnet_id
    tags    =   {
        Env     =   "dev"
        server  =   "private"
    }
}


