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

# IAM 정책 문서
# ECS Task Execution Role. 목표: AWS ECS가 AWS ECR에 적법한 접근 권한을 행사하여 Image를 Pull 할 수 있게 한다.
resource "aws_iam_role" "allow_ecs" {
  name               = "Simple-Web"
  assume_role_policy = file("iam/role/ECS-AssumeRole.json")

  description = "Let ECS to assume Role"
  tags = {
    "IaCTool" = "Terraform"
  }
}

resource "aws_iam_policy" "allow_ecs" {
  name   = "Simple-Web-Access"
  policy = file("iam/policy/ECS-AllowECRAccess.json")
}

resource "aws_iam_role_policy_attachment" "attach_document" {
  role       = aws_iam_role.allow_ecs.name
  policy_arn = aws_iam_policy.allow_ecs.arn
}
## 정책이 만들어지지 않아 잠시 주석 처리
#Create ECS Task Definition
# resource "aws_ecs_task_definition" "simple_web" {
#   family = "simple-web"
#   container_definitions = file("ecs/task_definitions/simple_web.json")

#   execution_role_arn = ""
# }