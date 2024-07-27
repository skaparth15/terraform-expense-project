terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.52.0"
    }
  }

   backend "s3" {
    bucket = "ilovedevops"
    key    = "terraform-bastion-project"
    region = "us-east-1"
  }
}

provider "aws" {



}
