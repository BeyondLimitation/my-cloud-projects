# Terraform # 필수 Provider의 요구 조건 설정
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Terraform # AWS Provider
provider "aws" {
  region = var.region
}


# S3 # Terraform State 를 저장할 Bucket. 생성 이후 
resource "aws_s3_bucket" "static_web_sre-state_storage" {
  bucket = var.bucket_name
  region = var.region
  tags   = var.env_bootstrap
}
# S3 # Bucket Versioning 활성화
resource "aws_s3_bucket_versioning" "static_web_sre-enable_versioning" {
  # Versioning을 활성화 할 Bucket 지정
  bucket = aws_s3_bucket.static_web_sre-state_storage.id

  # Bucket Versioning 활성화
  versioning_configuration {
    status = "Enabled"
  }
}

# IAM # Github Action이 사용할 IAM OIDC Connector
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = var.client_id_list
  thumbprint_list = var.thumbprint_list

  tags = var.env_bootstrap
}