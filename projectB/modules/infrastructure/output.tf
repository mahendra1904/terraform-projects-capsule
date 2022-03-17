
# to pass the value of this output in differengt module
output "ami_id" {
    value = data.aws_ami.amzlinux.id
}

