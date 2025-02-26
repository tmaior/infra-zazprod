provider "aws" {
  region = local.region
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46"
    }
  }

  backend "s3" {
    bucket         = "terraform-654654523718"
    key            = "aws/prod/us-east-1-virginia/infrastructure/terraform.tfstate"
    region         = "us-east-1"
  }
}
