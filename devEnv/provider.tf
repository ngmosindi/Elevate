provider "aws" {
  region  = var.region
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "terraform-elevate-state"
    key = "devEnv.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}
