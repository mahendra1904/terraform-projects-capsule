
output "web_sg"{
    value   =   aws_security_group.web_http.id
}

output "ssh_sg" {
    value = aws_security_group.ssh.id
}

