resource "aws_ecr_repository" "repositories" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  tags = var.tags
}
