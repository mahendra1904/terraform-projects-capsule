# define some output varibale that will help to pass the value in different module

output "vpc_id" {
  description = "vpc id of the  infrastructure"
  value = aws_vpc.dev_vpc.id 
}  

output "public_subnet_id" {
  description = "public subnet id of the  infrastructure"
  value = aws_subnet.public.id
}  

output "private_subnet_id" {
  description = "subnet id of the private servers"
  value = aws_subnet.private.id
}

