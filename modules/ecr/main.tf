resource "aws_ecr_repository" "my_ecr" {
    name = var.repository_name
    force_delete = true
}