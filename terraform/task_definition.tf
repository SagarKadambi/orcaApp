locals {
  repository_url = "${aws_ecr_repository.orcaApp.repository_url}:${var.orca_app_image_tag}"
  database_url   = "postgresql://${aws_db_instance.rds_instance.username}:${aws_db_instance.rds_instance.password}@${aws_db_instance.rds_instance.endpoint}/${aws_db_instance.rds_instance.name}"
}

data "aws_region" "current" {}

data "template_file" "task_definition_template" {
  template = file("task_definition.json.tpl")
  vars = {
    REPOSITORY_URL = local.repository_url
    DATABASE_URL   = local.database_url
    CW_LOG_GROUP   = aws_cloudwatch_log_group.orcaApp.name
    AWS_REGION     = data.aws_region.current.name
    CONTAINER_PORT = var.orca_app_port
  }
}

# create and define the container task
resource "aws_ecs_task_definition" "task_definition" {
  family = "orca-app"
  requires_compatibilities = [
  "FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = 1024
  memory                = 2048
  container_definitions = data.template_file.task_definition_template.rendered
  execution_role_arn    = aws_iam_role.iam_ecs_role.arn
  task_role_arn         = aws_iam_role.iam_ecs_role.arn
}