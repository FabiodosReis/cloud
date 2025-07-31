#config aws iam para o agent do ecs ter permissão.
#com essas configs o ecs será capas de iniciar, configurar os logs cloudWatch e pegar informações do ECR

#definindo a politica de acesso
data "aws_iam_policy_document" "ecs_task_execute_role_policy" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

#ecs-execution-role, cria uma role para permitir que o ecs execute outros serviços da AWS
resource "aws_iam_role" "ecs_execution_role" {
  name               = "ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execute_role_policy.json
}

#attachando a role de execução do ECS com as permissões para executar os processos do ecs
resource "aws_iam_role_policy_attachment" "ecs_task_role_default" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy" #essa policy é default da AWS(AmazonECSTaskExecutionRolePolicy)
}

#task-execution-role, cria uma role para permitir que as tasks execute outros serviços da AWS
resource "aws_iam_role" "task-execution_role" {
  name               = "task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execute_role_policy.json
}

#definindo uma policy para as tasks executarem serviçoes de RDS na AWS
resource "aws_iam_policy" "ecs_task_rds_policy" {
  name        = "ecs_task_execution_rds_policy"
  description = "Permite acesso total ao RDS em uma conta e região específica"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "rds:*"
        Resource = [
          "arn:aws:rds:${var.aws_region}:${data.aws_caller_identity.current.account_id}:db/*"
        ]
      }
    ]
  })
}

#attacha a policy na role da task para executar recursos do ECS
resource "aws_iam_role_policy_attachment" "ecs_task_role_rds" {
  role       = aws_iam_role.task-execution_role.name
  policy_arn = aws_iam_policy.ecs_task_rds_policy.arn
}
