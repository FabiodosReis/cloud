#Criando o repositorio para guardar as imagems da api
resource "aws_ecr_repository" "ecr_repository" {
  name                 = "repository_${var.project}"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
}

#Configurando o repositorio da imagem da api para ter até 5 imagens
resource "aws_ecr_lifecycle_policy" "retain_last_5" {
  repository = aws_ecr_repository.ecr_repository.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the last 5 images"
        selection = {
          tagStatus   = "any" # pode ser "tagged", "untagged" ou "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
