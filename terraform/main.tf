terraform {
  cloud {
    organization = "sagar-kadambi"

    workspaces {
      name = "ocraApp"
    }
  }
  # required_providers {
  #   aws = {
  #     source = "hashicorp/aws"
  #     version = "4.11.0"
  #   }
  # }
}


resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-tf-test-bucket"
}