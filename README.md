Terraform Projects
Group : A

Create the infrastructure  in terraform that will create the following resources in aws:

AWS s3 bucket 
multiple s3 bucket
ec2 server
dynamoDB table 
IAM role creation
s3 web hosting
 
Group : B

a. AWS VPC creation:

In this infrastructure create a vpc and the below resources which are attached to this custom vpc:
vpc
two subnet (one is public and other is private)
internet gateway
route table
route table association (private table with private subnet and public    table with public subnet)


Excel sheet for this infrastructure:



Draw a diagram to show infrastructure of vpc and create an excel sheet in which all the details of CIDR will be mentioned of the servers and subnets with proper naming convention.

b. Write a terraform script for the below scenario:

As soon as any object is uploaded in  s3 bucket a lambda function will trigger and that will make an entry in the dynamodb table. 
	
Group : C

     a. Create a CI/CD pipeline with terraform.
    b. Create a sftp server with terraform.


