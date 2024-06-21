resource "aws_ecr_repository" "flask_app_repo" {
  name = "flask-app-repo"
}

# DEBUG: commented out to test locally
# output "ecr_repository_url" {
#   value = aws_ecr_repository.flask_app_repo.repository_url
# }
