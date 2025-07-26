#https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create

terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }

  backend "s3" {
    bucket  = "tfstate-2025-381492217956"
    key     = "remote-state/terraform.tfstate"
    region  = "us-east-1"
    profile = ""
  }
}

module "sg" {
  source      = "./modules/02-security-group"
  aws_region  = local.aws_attr.aws_region
  common_tags = local.common_tags
  project     = var.project
}

module "ecr" {
  source      = "./modules/03-ecr"
  aws_region  = local.aws_attr.aws_region
  common_tags = local.common_tags
  project     = var.project
}

module "ecs" {
  source      = "./modules/04-ecs"
  aws_region  = local.aws_attr.aws_region
  common_tags = local.common_tags
  project     = var.project
}

variable "project" {
  type = string
}




