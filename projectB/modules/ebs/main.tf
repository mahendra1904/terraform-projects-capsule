
resource "aws_elastic_beanstalk_application" "ebs-app"{
    name    =   var.ebs_app_name

}
resource "aws_elastic_beanstalk_environment" "ebs_app_env"{
    name    =   var.env_name
    application   =   "${aws_elastic_beanstalk_application.ebs-app.name}"
    solution_stack_name = var.solution_stack_name

    setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-779ced0a"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-982504c7"
  }
  cname_prefix = "ovo-microservice-example-uat-domain"
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }
  
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "true"
  }
  
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
  
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }
  


}
