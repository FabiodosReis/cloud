output "sg-alb" {
  value = {
    id = aws_security_group.alb-sg.id
  }
}

output "sg-project" {
  value = {
    id = aws_security_group.project-sg.id
  }
}