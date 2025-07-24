#https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create

provider "aws" {
  region = var.aws_region

  default_tags {
   tags = local.common_tags
  }

}
