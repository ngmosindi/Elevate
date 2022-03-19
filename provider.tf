terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
  }
}

# Configure the AWS Provider}
provider "aws" {
  profile = var.profile_name
  region = var.region
}

