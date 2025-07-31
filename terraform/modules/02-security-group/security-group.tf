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
  description = "security group allow external http connection"
  vpc_id      = module.network.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#saida para qualquer conexao
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sg_alb_${var.project}"
  }

}

#Criando o security group da api e associando a VPC padrão.
resource "aws_security_group" "project-sg" {
  name        = "${var.project}_sg"
  description = "security group allow http connection to apps"
  vpc_id      = module.network.vpc.id

  #permite trafico interno da rede para a app
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc.cidr_block]
  }

  #permite trafico interno do alb para a app
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }


  egress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [module.network.vpc.cidr_block]
  }

  tags = {
    "Name" = "sg_${var.project}"
  }

}