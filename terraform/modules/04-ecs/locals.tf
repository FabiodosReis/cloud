locals {
  environment = [
    {
      name  = "SPRING_PROFILES_ACTIVE"
      value = "dev"
    },
    {
      name  = "AWS_REGION"
      value = var.aws_region
    }
  ]
  container_name          = "container_${var.project}"
  aws_log_group_name      = "/ecs/${var.project}"
  container_port          = 8080
  autoscaling_resource_id = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.this.name}"
}