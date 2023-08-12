terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  /*backend "s3" {
    bucket = "bootcamp29-26-david"
    key    = "dev/terraform.tfstate"
    #dynamodb_table = "terraform-lock"
    region = "us-west-2"
  }*/
}

provider "aws" {
  region = var.region[0]
}

