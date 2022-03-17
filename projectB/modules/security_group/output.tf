 # output variables to pass the value of this output for the different modules
output "web_sg"{
    value   =   aws_security_group.web_http.id
}

output "ssh_sg" {
    value = aws_security_group.ssh.id
}

