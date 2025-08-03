#Essa configuração vai para dentro do projeto quando a pipe do projeto estiver pronto.
resource "aws_cloudwatch_log_group" "this" {
  name              = local.aws_log_group_name #precisa ser igual a config da taskdefinition
  retention_in_days = 7

  tags = {
    Name = var.project
  }
}