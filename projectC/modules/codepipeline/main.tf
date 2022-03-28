
resource "aws_codepipeline" "pipeline_pmc" {
    name    =   var.pipeline_name
    role_arn = aws_iam_role.codepipeline_role.arn

    artifact_store {
      location = var.location_s3
      type = "S3"
      }
    stage {
        name    =   "Source"
        action  {
            name =  "Source"
            category    =   "Source"
            owner  =   "AWS"
            provider    =   "CodeStarSourceConnection"
            version     =   "1"
            output_artifacts    =   ["source_output"]
            configuration = {
                ConnectionArn    = aws_codestarconnections_connection.git_connect.arn
                FullRepositoryId = var.git_repo_id
                BranchName       = var.git_branch
            }
        }
    }

    stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.build_project_name
      }
    }
  }
  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = var.ecs_clustername
        ServiceName = var.ecs_servicename
        
      }
    }
  }
}

# The aws_codestarconnections_connection resource is created in the state PENDING. Authentication with the connection provider must be completed in the AWS Console.

resource "aws_codestarconnections_connection" "git_connect" {
    name    =   "github_connect"
    provider_type = "GitHub"
  
}


resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = var.pipeline_bucket
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  acl    = "private"
}

resource "aws_iam_role" "codepipeline_role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.codepipeline_bucket.arn}",
        "${aws_s3_bucket.codepipeline_bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:UseConnection"
      ],
      "Resource": "${aws_codestarconnections_connection.git_connect.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    },
    {
      "Effect" : "Allow",
      "Action" : [
        "codedeploy:*"
      ],
      "Resource" : [
        "*"
      ]
    }
  ]
}
EOF
}
    
  
