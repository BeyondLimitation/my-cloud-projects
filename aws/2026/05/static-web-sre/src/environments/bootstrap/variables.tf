variable "aws_id" {
  type        = number
  description = "AWS ID"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "ap-northeast-2"
}

variable "bucket_name" {
  type        = string
  description = "Project에 사용할 Bucket 이름"

  validation {
    # 1. 3자 이상 63자 이하
    # 2. 소문자, 숫자, 점(.), 하이픈(-)만 허용
    # 3. 시작과 끝은 소문자 또는 숫자여야 함
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "S3 버킷 이름은 3~63자의 소문자, 숫자, 점(.), 하이픈(-)만 사용할 수 있으며, 소문자나 숫자로 시작하고 끝나야 합니다."
  }

  validation {
    # 연속된 점(..)은 허용되지 않음
    condition     = !can(regex("\\.\\.", var.bucket_name))
    error_message = "S3 버킷 이름에 연속된 점(..)을 포함할 수 없습니다."
  }

  validation {
    # IP 주소 형식(예: 192.168.5.4)은 허용되지 않음
    condition     = !can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.bucket_name))
    error_message = "S3 버킷 이름은 IP 주소 형식과 같을 수 없습니다."
  }

  validation {
    # 특정 접두사로 시작 금지
    condition = !startswith(var.bucket_name, "xn--") && !startswith(var.bucket_name, "sthree-") && !startswith(var.bucket_name, "amzn-s3-demo-")
    error_message = "특정 접두사 'xn--', 'sthree-', 'amzn-s3-demo-'로 시작하면 안됩니다."
  }

  validation {
    # 특정 접두사로 끝 금지
    condition = !endswith(var.bucket_name, "-s3alias") && !endswith(var.bucket_name, "--ol-s3") && !endswith(var.bucket_name, ".mrap") && !endswith(var.bucket_name, "--x-s3") && !endswith(var.bucket_name, "--table-s3")
    error_message = "특정 접두사 '-s3alias', '--ol-s3', '.mrap', '--x-s3', '--table-s3'로 끝나면 안됩니다."
  }
}

variable "env_bootstrap" {
  type        = map(string)
  description = "Bootstrap 환경에서 생성된 태그"
  default = {
    "Environment" = "Bootstrap"
    "IaCTool"     = "Terraform"
  }
}