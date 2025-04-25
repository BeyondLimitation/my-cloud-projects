# Create AWS ECR Private Registry
resource "aws_ecr_repository" "simple_web" {
  name = "cloud-projects"

}

# Create ECS Cluster.
resource "aws_ecs_cluster" "web_server" {
  name = "Simple-Web-Server"
  # Add Tag.
  tags = {
    # This Cluster is created & managed using Terraform
    "IaCTool" = "Terraform"
  }
}