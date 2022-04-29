locals {
  repository_url = "var.flask_app_image:${orca_app_image_tag}"
}
data "template_file" "task_definition_template" {
  template = file("task_definition.json.tpl")
  vars = {
    REPOSITORY_URL    = local.repository_url
    POSTGRES_USERNAME = aws_db_instance.rds_instance.username
    POSTGRES_PASSWD   = aws_db_instance.rds_instance.password
    POSTGRES_ENDPOINT = aws_db_instance.rds_instance.endpoint
    POSTGRES_DATABASE = aws_db_instance.rds_instance.name

  }
}

# create and define the container task
resource "aws_ecs_task_definition" "task_definition" {
  family = "flask-app"
  requires_compatibilities = [
  "FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = 256
  memory                = 512
  container_definitions = data.template_file.task_definition_template.rendered
}