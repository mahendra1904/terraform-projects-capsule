# in this module the application code will store in s3 bucket and from ebs take the code from s3 bucket
# to enableing the versoing of the bucket we can deploy app form v1 to v2.

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket
  versioning {
    enabled = true
  }

  # lifecycle_rule {
  #   id = "retention"
  #   enabled = true


  #   noncurrent_version_expiration {
  #     days = 90
  #   }
  # }
}

# resource to create the objects in s3 bucket
resource "aws_s3_bucket_object" "app_code" {
  bucket = aws_s3_bucket.app_bucket.id
  key    = var.key
  source = "F:/GIIT/terraform-project-capsule/projectB/modules/ebs-s3/nodeAppCustomecodeEBS.zip"
}

# resource to create the applicatin in ebs

resource "aws_elastic_beanstalk_application" "ebs-app"{
    name    =   var.ebs_app_name

}


# resource to create the app version that will take the zip file code from s3 bucket
resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = var.app_version_name
  application = aws_elastic_beanstalk_application.ebs-app.name # name of app
  bucket      = aws_s3_bucket.app_bucket.id # bucket name of s3
  #key         = aws_s3_bucket_object.app_code.id
  key         = aws_s3_bucket_object.app_code.key # object name for the s3 bucket
  depends_on  = [aws_elastic_beanstalk_application.ebs-app] # this block tells that this app version will be depends on the ebs application 
}

# create the environment for the app
resource "aws_elastic_beanstalk_environment" "ebs_app_env"{
    #name    =   var.env_name
    name     =  aws_elastic_beanstalk_application.ebs-app.name
    application   =   "${aws_elastic_beanstalk_application.ebs-app.name}"
    solution_stack_name = var.solution_stack_name
    version_label  = aws_elastic_beanstalk_application_version.app_version.name # must ne given to take the corrent version form the s3 bucket
# setting block will create the aws resource in aws in which your app will deploy
    setting {
    namespace = "aws:ec2:vpc"  # name of the aws resource
    name      = "VPCId"  # name of the resource
    value     = var.vpc_id # resource value
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
 
# setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     =  "${aws_iam_role.ebs_role.arn}"
#   }
   

}
