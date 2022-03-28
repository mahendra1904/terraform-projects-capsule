variable "codebuild_iam_role" {
    type = string
  
}

variable "managed_policies" {
  default = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess"
   
  ]
}
