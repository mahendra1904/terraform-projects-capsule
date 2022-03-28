# create aww codebuild resouce
resource "aws_codebuild_project" "codebuild" {
    name = var.codebuildname
    service_role = var.codebuild_service_role 
    tags = {
      "Environment" = var.env
    }

    artifacts {
    type = "NO_ARTIFACTS"
  }
    # environment for codebuild
    environment {
      compute_type  =   "BUILD_GENERAL1_SMALL"
      image                       = "aws/codebuild/standard:5.0"
      image_pull_credentials_type = "CODEBUILD"
      privileged_mode             = true
      type                        = "LINUX_CONTAINER"
      

    }
  
    logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }

  }
  # source coe from it will create the build project
  source {
    type            = "GITHUB"
    location        = "https://github.com/mahendra1904/node-app"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

# resource to create webhook

resource "aws_codebuild_webhook" "webhook" {
  project_name = aws_codebuild_project.codebuild.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
  }
}


  