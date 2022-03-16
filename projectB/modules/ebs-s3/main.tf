# in this module the application code will store in s3 bucket and from ebs take the code from s3 bucket
# to enableing the versoing of the bucket we can deploy app form v1 to v2.

resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket
  versioning {
    enabled = true
  }

  lifecycle_rule {
    id = "retention"
    enabled = true


    noncurrent_version_expiration {
      days = 90
    }
  }
}


resource "aws_s3_bucket_object" "app_code" {
  bucket = aws_s3_bucket.app_bucket.id
  key    = var.key
  source = "F:/GIIT/terraform-project-capsule/projectB/modules/ebs-s3/nodeAppCustomecodeEBS.zip"
}


resource "aws_elastic_beanstalk_application" "ebs-app"{
    name    =   var.ebs_app_name

}

resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = var.app_version_name
  application = aws_elastic_beanstalk_application.ebs-app.name
  bucket      = aws_s3_bucket.app_bucket.id
  key         = aws_s3_bucket_object.app_code.id
}


resource "aws_elastic_beanstalk_environment" "ebs_app_env"{
    name    =   var.env_name
    application   =   "${aws_elastic_beanstalk_application.ebs-app.name}"
    solution_stack_name = var.solution_stack_name

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
 
# setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     =  "${aws_iam_role.ebs_role.arn}"
#   }
   

}
