locals {
  repository_url = "${aws_ecr_repository.orcaApp.repository_url}:${var.orca_app_image_tag}"
}

data "aws_region" "current" {}

data "template_file" "task_definition_template" {
  template = file("task_definition.json.tpl")
  vars = {
    REPOSITORY_URL    = local.repository_url
    POSTGRES_USERNAME = aws_db_instance.rds_instance.username
    POSTGRES_PASSWD   = aws_db_instance.rds_instance.password
    DATABASE_URL      = aws_db_instance.rds_instance.endpoint
    POSTGRES_DATABASE = aws_db_instance.rds_instance.name
    CW_LOG_GROUP      = aws_cloudwatch_log_group.orcaApp.name
    AWS_REGION        = data.aws_region.current.name
  }
}

# create and define the container task
resource "aws_ecs_task_definition" "task_definition" {
  family = "orca-app"
  requires_compatibilities = [
  "FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = 256
  memory                = 512
  container_definitions = data.template_file.task_definition_template.rendered
  execution_role_arn       = aws_iam_role.iam_ecs_role.arn
  task_role_arn            = aws_iam_role.iam_ecs_role.arn
}