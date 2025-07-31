#Criando o cluster da api e setando as configs do CloudWatch
resource "aws_ecs_cluster" "ecs_project" {
  name = "cluster_${var.project}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}



###########Essa parte aqui vou ter que configurar dentro do projeto da api e nao no projeto do terraform
#Criando a task definition
resource "aws_ecs_task_definition" "this" {
  family                   = "taskdef_${var.project}"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn #no projeto vou ter que setar a role especifica(ecs-execution-role)
  task_role_arn            = aws_iam_role.task-execution_role.arn #no projeto vou ter que setar a role especifica(task-execution-role)
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs.fargate_cpu #vou pegar esse valor de dentro do projeto
  memory                   = var.ecs.fargate_memory #vou pegar esse valor de dentro do projeto

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  container_definitions = jsonencode([{
    name  = "container_${var.project}"
    image = "381492217956.dkr.ecr.us-east-1.amazonaws.com/cloud-api:latest" #precisa setar uma imagem válida para funcionar
    essential = true
    environment = local.environment

    portMappings = [
      {
        containerPort = var.ecs.app_port
        hostPort      = var.ecs.app_port
        protocol      = "tcp"
      }
    ]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/${var.project}"
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}
##########################################
