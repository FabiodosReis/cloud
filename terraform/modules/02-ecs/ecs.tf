#Criando o cluster da api e setando as configs do CloudWatch
resource "aws_ecs_cluster" "ecs_cluster" {
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
  execution_role_arn       = data.terraform_remote_state.remote.outputs.role.ecs_execution_role #no projeto vou ter que setar a role especifica(ecs-execution-role)
  task_role_arn            = data.terraform_remote_state.remote.outputs.role.task_executon_role #aws_iam_role.task-execution_role.arn #no projeto vou ter que setar a role especifica(task-execution-role)
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs.fargate_cpu    #vou pegar esse valor de dentro do projeto
  memory                   = var.ecs.fargate_memory #vou pegar esse valor de dentro do projeto

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  container_definitions = jsonencode([{
    name        = local.container_name
    image       = var.ecr_image #precisa setar uma imagem válida para funcionar
    essential   = true
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
        awslogs-group         = local.aws_log_group_name
        awslogs-region        = local.aws_region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

#criando o service para o ecs gerenciar as tarefas
resource "aws_ecs_service" "this" {
  name                              = "service_${var.project}"
  cluster                           = aws_ecs_cluster.ecs_cluster.id
  task_definition                   = aws_ecs_task_definition.this.arn
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 30 #depois de 30s o serviço irá checar se a tarefa subiu

  desired_count                      = 1   #quantidade de tasks que o serviço irá rodar no deployment
  deployment_minimum_healthy_percent = 0   #signica que o ecs pode parar todos os containers no processo de deploy
  deployment_maximum_percent         = 100 #significa que o maximo de tasks rodando durante o deploy seria = desired_count

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = var.sg_app
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.arn
    container_name   = local.container_name
    container_port   = local.container_port
  }

  depends_on = [
    aws_alb_listener.http
  ]

  #ignora mudanças do auto scalling
  lifecycle {
    ignore_changes = [desired_count]
  }

}
##########################################
