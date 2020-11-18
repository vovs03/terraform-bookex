terraform {
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs
  # For Terraform ~> v.0.13.4
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
    # Ohio
    region = "us-east-2"

}

# Creating bucket S3
resource "aws_s3_bucket" "terraform_state" {
    #### Setup 4 arguments:
    # 01 Need use unique <BUCKET_NAME>
    bucket = "terraform-bookex-state"

    # 02 Safe_mode for undeleting this bucket S3
    lifecycle {
        prevent_destroy = true
    }

    # 03 Versioning_enable for watching history of tf_state_files
    versioning {
        enabled = true
    }

    # 04 Switch_On Encrypting 
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

