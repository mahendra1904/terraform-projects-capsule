
resource "aws_vpc" "dev_vpc"{

    cidr_block    =   var.vpc_cidr
    tags    =   {
        Name    =   "dev"
    }
}

resource "aws_subnet" "public"{
    vpc_id  =   aws_vpc.dev_vpc.id
    cidr_block    =   var.public_cidr
    availability_zone   =   var.public_az
    map_public_ip_on_launch =   true
    tags    =   {
        Name    =   "dev_public"
    }
}

resource "aws_subnet" "private"{
    vpc_id  =   aws_vpc.dev_vpc.id
    cidr_block    =   var.private_cidr
    availability_zone   =   var.private_az
    tags    =   {
        Name    =   "dev_private"   
    }
}

resource "aws_internet_gateway" "igw"{
    vpc_id  =   aws_vpc.dev_vpc.id
    tags    =   {
        Name    =   "public_igw"
    }
}

resource "aws_route_table" "route_table" {
    vpc_id  =   aws_vpc.dev_vpc.id
    tags    =   {
        Name    =   "public route table"
    }

    route   {
        cidr_block  =   "0.0.0.0/0"
        gateway_id  =   aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "public_rta"{
    route_table_id  =   aws_route_table.route_table.id
    subnet_id       =   aws_subnet.public.id
}


resource "aws_route_table_association" "private_rta"{
    route_table_id  =   aws_route_table.route_table.id
    subnet_id       =   aws_subnet.private.id
}




