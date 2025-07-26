#importando o modulo network para usar os outputs do modulo local
module "network" {
  source      = "../01-network"
  aws_region  = var.aws_region
  common_tags = var.common_tags
  project     = var.project
}

#Criando o security group do alb e associando a VPC padrão e ao internet gateway.
resource "aws_security_group" "alb-sg" {
  name        = "alb_sg_${var.project}"
  description = "security group allow http connection in internal resource"
  vpc_id      = module.network.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "alb_sg_${var.project}"
  }

}

#Criando o security group da api e associando a VPC padrão.
resource "aws_security_group" "project-sg" {
  name        = "${var.project}_sg"
  description = "security group allow http connection in internal resource"
  vpc_id      = module.network.vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc.cidr_block]
  }

  tags = {
    "Name" = "alb_sg_${var.project}"
  }

}