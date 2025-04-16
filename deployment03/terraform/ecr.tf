resource "aws_ecr_repository" "flask_repo" {
  name = "flask-backend-repo-2"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_repository" "express_repo" {
  name = "express-frontend-repo-2"
  lifecycle {
    prevent_destroy = true
  }
}