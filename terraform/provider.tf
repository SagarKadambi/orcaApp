provider "aws" {
  region = var.region
}

# random string for flask secret-key env variable
resource "random_string" "flask-secret-key" {
  length = 16
  special = true
  override_special = "/@\" "
}