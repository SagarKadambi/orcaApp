resource "aws_cloudwatch_log_group" "orcaApp" {
  name              = "/aws/ecs/orcaApp"
  retention_in_days = 365
}