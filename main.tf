terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "state_object" {
  bucket = "terraform-multiaz"
}

terraform {
  backend "s3" {
    bucket = "terraform-multiaz"
    key    = "state.tf"
    region = "ap-northeast-1"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ab3794db9457b60a"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
