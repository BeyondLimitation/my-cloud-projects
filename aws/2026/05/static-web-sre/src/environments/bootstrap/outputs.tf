output "s3_bucket_arn" {
  description = "S3 Bucket의 ARN"
  value       = aws_s3_bucket.static_web_sre-state_storage.arn
}

output "iam_oidc_provider" {
  description = "AWS IAM Open ID Provider의 ARN"
  value       = aws_iam_openid_connect_provider.github.arn
}