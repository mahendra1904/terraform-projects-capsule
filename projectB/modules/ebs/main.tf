

# resource to create a ebs app
resource "aws_elastic_beanstalk_application" "ebs-app"{
    name    =   var.ebs_app_name

}

# resource to create a environment for application 
resource "aws_elastic_beanstalk_environment" "ebs_app_env"{
    name    =   var.env_name
    application   =   "${aws_elastic_beanstalk_application.ebs-app.name}"
    solution_stack_name = var.solution_stack_name  # plateform for the environment

    setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = var.subnet_id
  }
  cname_prefix = var.cname_prefix
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
    value = var.instance_type
  }
  
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
    
  }
  


}
