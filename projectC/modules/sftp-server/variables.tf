variable "name" {
    type = string
  
}
variable "acl" {
    type = string
  
}
variable "bucket_versioning" {
    type = bool
  
} 

variable "bucket_name" {
    type = string
  
}

variable "bucket_object_key" {
    type = list(any)
  
}

#################

variable "sftp_iam_role" {
    type = string
  
}
variable "sftp_iam_policy_name" {
    type = string
}

variable "s3_policy" {
    default = ""
  
}

variable "sftp_user_name" {
    type = list(any)
  
}

variable "sftp_bucket_name" {
    type = string
  
}

variable "ssh-public" {
    default = ""
  
}