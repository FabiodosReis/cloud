locals {
  environment = [
    {
      name = "SPRING_PROFILES_ACTIVE"
      value = "dev"
    },
    {
      name = "AWS_REGION"
      value = var.aws_region
    }
  ]
}