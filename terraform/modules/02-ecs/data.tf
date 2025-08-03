data "aws_caller_identity" "current" {}

#configurando modulo remoto
data "terraform_remote_state" "remote" {
  backend = "s3"

  config = {
    bucket = "tfstate-2025-381492217956"
    key    = "remote-state/terraform.tfstate"
    region = "us-east-1"
  }

}