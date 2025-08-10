locals {
  environment = [
    {
      name  = "SPRING_PROFILES_ACTIVE"
      value = "staging"
    },
    {
      name  = "AWS_REGION"
      value = local.aws_region
    }
  ]

  aws_region              = "us-east-1"
  container_name          = "container_${var.project}"
  aws_log_group_name      = "/ecs/${var.project}"
  container_port          = 8080
  autoscaling_resource_id = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.this.name}"


  common_tags = {
    Project    = "Terraform"
    CreateAt   = "2025-07-24"
    ManageBy   = "Terraform"
    Owner      = "Fábio Reis"
    Repository = "git@github.com:FabiodosReis/cloud.git"
    env        = "staging"
  }

  remote_state_value = {
    vpc_id          = data.terraform_remote_state.remote.outputs.vpc.id
    sg_alb          = [data.terraform_remote_state.remote.outputs.sg_alb.id]
    sg_app          = [data.terraform_remote_state.remote.outputs.sg_app.id]
    public_subnets  = flatten(data.terraform_remote_state.remote.outputs.subnets.public.id)
    private_subnets = flatten(data.terraform_remote_state.remote.outputs.subnets.private.id)
  }

}