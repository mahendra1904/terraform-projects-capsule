
output "vpc_id" {
  description = "vpc id of the  infrastructure"
  value = aws_vpc.dev_vpc.id 
}  

output "public_subnet_id" {
  description = "public subnet id of the  infrastructure"
  value = aws_subnet.public.id
}  
