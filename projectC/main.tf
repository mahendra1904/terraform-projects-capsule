# terraform aws provider
provider "aws" {
  region = "us-east-1"
}


module "s3" {
  source          = "./modules/s3-backend"
  bucket_name     = "terraform-backend-bucket-giit"
  artifact_bucket = "artifact-store-bucket-pipeline"

}

module "iam_role" {
  source             = "./modules/iam-role-cicd"
  codebuild_iam_role = "codebuild-service-role-node-app-cicd-final"


}

module "build" {
  source                 = "./modules/codebuild"
  env                    = "dev"
  codebuildname          = "pmc-build-project"
  codebuild_service_role = module.iam_role.code_build_role_arn

}

 
module "pipeline" {
  source             = "./modules/codepipeline"
  pipeline_name      = "pipeline-pmc"
  location_s3        = module.s3.artifact_bucket_name
  git_repo_id        = "mahendra1904/node-app"
  git_branch         = "master"
  build_project_name = module.build.code_build_name
  pipeline_bucket    = module.s3.artifact_bucket_name
  ecs_clustername = module.ecs-deployment.cluster_name
  ecs_servicename = module.ecs-deployment.service_name

} 



module "ecs-deployment" {
  source            = "./modules/ecs-cluster"
  ecs_cluster_name = "app_deploy"
  service_name = "node-app-service"


} 

 










