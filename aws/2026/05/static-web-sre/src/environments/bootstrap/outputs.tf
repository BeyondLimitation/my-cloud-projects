output "s3_bucket_arn" {
  description = "S3 Bucket의 ARN"
  value       = aws_s3_bucket.static_web_sre-state_storage.arn
}

output "dev_bucket_arn" {
  description = "개발용 S3 Bucket의 ARN"
  value       = aws_s3_bucket.static_web_sre-dev.arn
}

output "prod_bucket_arn" {
  description = "프로덕션용 S3 Bucket의 ARN"
  value       = aws_s3_bucket.static_web_sre-prod.arn
}


output "iam_oidc_provider" {
  description = "AWS IAM Open ID Provider의 ARN"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "iam_role-dev" {
  description = "IAM Role 'github-action_dev-branch'의 ARN"
  value       = aws_iam_role.github_action-dev.arn
}

output "iam_role-prod" {
  description = "IAM Role 'github-action_dev-branch'의 ARN"
  value       = aws_iam_role.github_action-prod.arn
}