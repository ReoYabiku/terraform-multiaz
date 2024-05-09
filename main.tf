terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "terraform-multiaz"
    key    = "state.tf"
    region = "ap-northeast-1"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ab3794db9457b60a"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = var.instance_name
  }
}
