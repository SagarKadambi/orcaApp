# Create repository

resource "aws_ecr_repository" "orcaApp" {
  name = "orcaapp"
}

# create the ECS cluster
resource "aws_ecs_cluster" "orca-ecs-cluster" {
  name = "orca-app"

  tags = {
    Name = "orcaApp"
  }
}