terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.52.0"
    }
  }

   backend "s3" {
    bucket = "ilovedevops1"
    key    = "terraform-backend-alb"
    region = "us-east-1"
  }
}

provider "aws" {



}
