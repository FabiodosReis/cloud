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

module "network" {
  source          = "./modules/01-network"
  aws_region      = local.aws_attr.aws_region
  common_tags     = local.common_tags
  project         = var.project
  sg_vpc_endpoint = [module.sg.sg_endpoint.id]
}

module "sg" {
  source         = "./modules/02-security-group"
  aws_region     = local.aws_attr.aws_region
  common_tags    = local.common_tags
  project        = var.project
  vpc_id         = module.network.vpc.id
  vpc_cidr_block = module.network.vpc.cidr_block
}

module "ecr" {
  source      = "./modules/03-ecr"
  aws_region  = local.aws_attr.aws_region
  common_tags = local.common_tags
  project     = var.project
}

module "ecs" {
  source          = "./modules/04-ecs"
  aws_region      = local.aws_attr.aws_region
  common_tags     = local.common_tags
  project         = var.project
  vpc_id          = module.network.vpc.id
  sg_alb          = [module.sg.sg_alb.id]
  sg_app          = [module.sg.sg_app.id]
  public_subnets  = module.network.subnets.public.id
  private_subnets = module.network.subnets.private.id
}

variable "project" {
  type = string
}




