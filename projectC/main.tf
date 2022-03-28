# terraform aws provider
provider "aws" {
  region = "us-east-1"
}



# aws s3 bucket to store the terraform state files
/* module "s3" {
  source          = "./modules/s3-backend"
  bucket_name     = "terraform-backend-bucket-giit"
  artifact_bucket = "artifact-store-bucket-pipeline"

}  */

/*
# module to create the iam role for aws codebuild
module "iam_role" {
  source             = "./modules/iam-role-cicd"
  codebuild_iam_role = "codebuild-service-role-node-app-cicd-final"


}

# module to create the aws codebuild
module "build" {
  source                 = "./modules/codebuild"
  env                    = "dev"
  codebuildname          = "pmc-build-project"
  codebuild_service_role = module.iam_role.code_build_role_arn

}

# module to create the aws pipeline 
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
# module to call the ecs deployment
module "ecs-deployment" {
  source            = "./modules/ecs-cluster"
  ecs_cluster_name = "app_deploy"
  service_name = "node-app-service"


} 
 */

module "sftp" {
  source            = "./modules/sftp-server"
  name              = "giit-pmc"
  acl               = "private"
  bucket_versioning = true
  bucket_name       = "sftp-server-pmc-giit"
  bucket_object_key = ["alpha", "beta", "yama"]
  sftp_iam_role = "sftp_iam_role"
  sftp_iam_policy_name = "sftp_policy"
  s3_policy =   "${file("./modules/sftp-server/s3-policy.json")}"
  sftp_user_name  = ["john","mahendra"]
  sftp_bucket_name = "/sftp-server-pmc-giit"
  ssh-public  = "${file("./modules/sftp-server/id_rsa.pub")}"


}






