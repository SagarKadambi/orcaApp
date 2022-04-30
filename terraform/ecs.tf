# Create repository

resource "aws_ecr_repository" "orcaApp" {
  name = "orcaapp"
}

# create the ECS cluster
resource "aws_ecs_cluster" "orca-ecs-cluster" {
  name = "orca-app"

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.orcaApp.name
      }
    }
  }

  tags = {
    Name = "orcaApp"
  }
}