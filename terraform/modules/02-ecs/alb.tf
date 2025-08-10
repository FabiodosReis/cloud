#Configurando o load balancer

resource "aws_alb" "this" {
  name               = "alb-${var.project}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = local.remote_state_value.sg_alb
  subnets            = local.remote_state_value.public_subnets
}

#Cria o target group de acordo com a porta da app
resource "aws_alb_target_group" "this" {
  name        = "tg-${var.project}"
  port        = local.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.remote_state_value.vpc_id

  health_check {
    unhealthy_threshold = "2"   #se falhar duas verificacoes consecutivas será considerado unhealth
    healthy_threshold   = "3"   #quantas vezes o target precisa responder para ser considerado health
    interval            = "60"  #60 segundos para cada checagem
    matcher             = "200" #codigo http para verificar se está health
    timeout             = "3"   # tem até 3 segundos para responder se está health
    path                = "/actuator/health"
  }
}

#Adiciona um listener na porta 80 para o load balancer e relaciona o target group
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80 #o endereço do load balancer funcionará na porta 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}