resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/devops-case-study/backend"
  retention_in_days = 7
}
