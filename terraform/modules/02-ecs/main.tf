terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }

  backend "s3" {
    bucket = "tfstate-2025-381492217956"
    key    = "remote-state/ecs/terraform.tfstate"
    dynamodb_table = "tf_lock_tfstate-2025-381492217956"  # usar lock
    region = "us-east-1"
  }
}


provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = merge(
      local.common_tags,
      { Component = "ecs" }
    )
  }
}