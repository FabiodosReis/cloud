#Criando o cluster da api e setando as configs do CloudWatch
resource "aws_ecs_cluster" "ecs_project" {
  name = "cluster_${var.project}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}