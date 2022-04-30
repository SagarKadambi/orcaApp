resource "aws_cloudwatch_log_group" "orcaApp" {
  name              = "orcaApp"
  retention_in_days = 365
}