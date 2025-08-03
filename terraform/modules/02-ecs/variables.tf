variable "project" {
  type        = string
  description = "default value for resource name"
}

variable "vpc_id" {
  type        = string
  description = "vpc id value"
  default = data.terraform_remote_state.remote.outputs.vpc.id
}

variable "sg_alb" {
  type        = list(string)
  description = "alb security group id value"
  default = [data.terraform_remote_state.remote.outputs.sg_alb.id]
}

variable "sg_app" {
  type        = list(string)
  description = "alb security group id value"
  default = [data.terraform_remote_state.remote.outputs.sg_app.id]
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnets ips"
  default = data.terraform_remote_state.remote.outputs.subnets.public.id
}

variable "private_subnets" {
  type        = list(string)
  description = "private subnets ips"
  default = data.terraform_remote_state.remote.outputs.subnets.private.id
}

variable "ecr_image" {
  type = string
  description = "ecr image value"
}

variable "ecs" {
  description = "values for ecs fargate configs definitions"
  type = object({
    fargate_cpu    = number
    fargate_memory = number
    app_count      = number
    app_port       = number
    health_check   = string
  })

  default = {
    fargate_cpu    = 512
    fargate_memory = 1024
    app_count      = 1
    app_port       = 8080
    health_check   = "/actuator/health"
  }
}

variable "autoscaling" {
  type = object({

    memory_autoscaling = object({
      target             = number
      scale_in_cooldown  = number
      scale_out_colldown = number
    })

    cpu_autoscaling = object({
      target             = number
      scale_in_cooldown  = number
      scale_out_colldown = number
    })

    alb_autoscaling = object({
      target = number
    })

  })

  default = {
    memory_autoscaling = {
      target             = 60
      scale_in_cooldown  = 300
      scale_out_colldown = 300
    }

    cpu_autoscaling = {
      target             = 40
      scale_in_cooldown  = 300
      scale_out_colldown = 300
    }

    alb_autoscaling = {
      target = 100 #valor bem pequeno apenas para fazer testes
    }
  }
}