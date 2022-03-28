# create locals for varibales
locals {
  name =    var.name
}

# create s3 bucket for sftp server
resource "aws_s3_bucket" "sftp_server_bucket" {
    bucket    =   var.bucket_name
    acl =   var.acl
    versioning {
        enabled = var.bucket_versioning
    }
    lifecycle {
      prevent_destroy = false
    }
    tags = {
        Name =local.name
    }
}

# create objects for sftp server
 resource "aws_s3_bucket_object" "this" {
    bucket = aws_s3_bucket.sftp_server_bucket.bucket
    for_each = toset(var.bucket_object_key)
    key = each.key
  
} 

###########################

# create sftp server
resource "aws_transfer_server" "sftp" {
    tags = {
        Name =local.name
    }
    identity_provider_type = "SERVICE_MANAGED"
  
}

# attached iam role for thos sftp server
resource "aws_iam_role" "sftp_role" {
    name =  var.sftp_iam_role
    assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "transfer.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# attached policy for this iam role
resource "aws_iam_role_policy" "sftp_role_policy" {
    role = aws_iam_role.sftp_role.id
    name = var.sftp_iam_policy_name
    policy = var.s3_policy
}

# create users who can access the sftp server
resource "aws_transfer_user" "sftp_user" {
    server_id = aws_transfer_server.sftp.id
    for_each = toset(var.sftp_user_name)
    user_name = each.key
    home_directory  =   var.sftp_bucket_name
    role = aws_iam_role.sftp_role.arn
    tags = {
        Name =local.name
    }
}

# store the ssh public key to the users so that they can access the sftp server with their home directory
resource "aws_transfer_ssh_key" "ssh_key" {
    server_id = aws_transfer_server.sftp.id
    for_each = toset(var.sftp_user_name)
    user_name = "${each.value}"
    body      = "${var.ssh-public}"
     
}