#https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project = "Terraform Cloud api"
      Component = "Remote State"
      CreateAt = "2025-07-24"
      ManageBy = "Terraform"
      Owner = "Fábio Reis"
      Repository = "git@github.com:FabiodosReis/cloud.git"
    }
  }

}
