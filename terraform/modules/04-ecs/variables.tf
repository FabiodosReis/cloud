variable "aws_region" {
  type        = string
  description = "default value for aws region"
}

variable "common_tags" {
  type = object({})
}

variable "project" {
  type        = string
  description = "default value for resource name"
}



variable "ecs" {
  description = "values for ecs fargate configs definitions"
  type = object({
    fargate_cpu = number
    fargate_memory = number
    app_count = number
    app_port = number
    health_check = string
  })

  default = {
    fargate_cpu = 256
    fargate_memory = 512
    app_count = 1
    app_port = 8080
    health_check = "/actuator/health"
  }
}