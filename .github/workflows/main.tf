#1) Terraform block
/* terraform {
     required_version= "~> 1.0"  1.1.4./5/6/7   1.2/3/4/5  1.1.4/5/6/7
     required_providers {
       aws = {
         source  = "hashicorp/aws"
         version = "~> 3.0"
       }
    } 
	
   /* backend "s3" {
      bucket = "terraform-mylandmark"
      key    = "prod/terraform.tfstate"
      region = "us-east-1"
      dynamodb_table = "terraform_lock"
    }
  }*/

#2) Provider block:  plugin /api

provider "aws" {
  #profile = "default" #AWS Credential Profile configured on your local desktop terminal $HOME/.aws/credentials
  #region       = "us-east-1"
  default_tags {
    tags = local.default_tags
  } 

}


#3)Resource block
resource "aws_instance" "bootcamp101" {
  #ami = "ami-0e5b6b6a9f3db6db8" # Amazon Linux
  ami           = data.aws_ami.amzlinux2.id
  #instance_type = var.instance_type[0]
  instance_type = var.instance_type
  #delete_on_termination =true

  tags = {
    Name = local.name
  }
}

# 4) Variables block: inputs

variable "instance_type" {
  description = "EC2 instance Type"
  #type        = list(string)
  type = any
  #type = string
  default = "t2.micro"
 # default = ["t2.micro", "t2.medium", "t3.large"]
}

variable "app_name" {
  description = "app_name"
  #type        = list(string)
  type    = string
  default = "jenkins"
}

variable "environment" {
  description = "environment"
  #type        = list(string)
  type    = string
  default = "production"
}
#5) Outputs block:

output "public_ip" {
  description = "ec2 instance publicip"
  value       = aws_instance.bootcamp101.public_ip
}
output "az" {
  description = "ec2 instance availability zone"
  value       = aws_instance.bootcamp101.availability_zone
}

#6) Local block:

locals {
  name = "${var.app_name}-${var.environment}"
  #portfolio = "jenkins-production"
  default_tags = {
    "Mike:Department" = "DevOps"
    "Mike:Portfolio"  = "CloudOps"
    "Mike:Managedby"  = "Terraform"
  }
}
#jenkins-production

data "aws_region" "current" {}
#7) Data Source block: 
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
/*
8) Module block:
   *************
   module "ec2" {
     source = "./my_instance"
     version = "1.0.1"
     
     instance_type = var.instance_tpye
   }
  
9) Moved block:  used to change the resource name from bootcamp31 to bootcamp30
   ***************
      moved {
        from = "aws_instance.bootcamp30"
        to = "aws_instance.bootcamp31"
      }
*/