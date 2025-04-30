## AWS ECR
# Create AWS ECR Private Registry
resource "aws_ecr_repository" "simple_web" {
  name = "cloud-projects"

}

## IAM 정책 문서
# ECS Task Execution Role. 목표: AWS ECS가 AWS ECR에 적법한 접근 권한을 행사하여 Image를 Pull 할 수 있게 한다.
resource "aws_iam_role" "allow_ecs" {
  name               = "Simple-Web"
  assume_role_policy = file("iam/role/ECS-AssumeRole.json")

  description = "Let ECS to assume Role"
  tags = {
    "IaCTool" = "Terraform"
  }
}
# 정책 문서. AWS ECR로 부터 Image를 받을 수 있도록 되어있음.
resource "aws_iam_policy" "allow_ecs" {
  name   = "Simple-Web-Access"
  policy = file("iam/policy/ECS-AllowECRAccess.json")
}
# 정책 문서를 역할에 연결
resource "aws_iam_role_policy_attachment" "attach_document" {
  role       = aws_iam_role.allow_ecs.name
  policy_arn = aws_iam_policy.allow_ecs.arn
}
### END

## ECS Service
# Create ECS Cluster.
resource "aws_ecs_cluster" "web_server" {
  name = "Simple-Web-Server"
  # Add Tag.
  tags = {
    # This Cluster is created & managed using Terraform
    "IaCTool" = "Terraform"
  }
}

# Create ECS Task Definition
resource "aws_ecs_task_definition" "simple_web" {
  family                = "simple-web"
  container_definitions = file("ecs/task_definitions/simple_web.json")

  # 하드웨어 설정
  cpu    = 256
  memory = 512

  # Fargate 최적화 설정
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  # 역할 연결. 정책을 통해 Image를 Registry에서 받을 수 있음.
  execution_role_arn = aws_iam_role.allow_ecs.arn

  tags = {
    "IaCTool" = "Terraform"
  }
}

# Subnet. VPC: ManualWorld
data "aws_subnet" "manual" {
  id = "subnet-0d3b3dcc71c493621"
}
# Security Group. VPC:ManualWorld
data "aws_security_group" "allow_all" {
  id = "sg-0a7970c7ed3b14b26"
}

# Run a standalone task. 
data "aws_ecs_task_execution" "run-flask" {
  cluster         = aws_ecs_cluster.web_server.id
  task_definition = aws_ecs_task_definition.simple_web.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnet.manual[*].id
    security_groups  = [data.aws_security_group.allow_all.id]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.simple_web, aws_iam_policy.allow_ecs]
}
### END