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