# terraform backend as s3
terraform {
  required_version = "~>1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}


# terraform block for terraform version and aws version
/* terraform {
  required_version = "~>1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
} 
 */

# terraform backend as s3 with latest version of hashicorp/aws
/* terraform {
  backend "s3" {
    bucket  = "terraform-backend-bucket-giit"
    encrypt = true
    key     = "terraform.tfstate"

  }
} */

/* 
terraform {
  required_version = "~>1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-backend-bucket-giit"
    encrypt = true
    key     = "terraform.tfstate"

  }
} */
