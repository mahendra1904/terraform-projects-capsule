# output variable to pass this value in different modules

output "ami_id" {
    value = data.aws_ami.amzlinux.id
}