locals {
  common_tags = {
    Project = "Terraform Cloud api"
    Component = "Network"
    CreateAt = "2025-07-24"
    ManageBy = "Terraform"
    Owner = "Fábio Reis"
    Repository = "git@github.com:FabiodosReis/cloud.git"
    Env = var.environment
  }
}