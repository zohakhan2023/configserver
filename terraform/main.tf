terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  #  backend "s3" {
  #    region = "us-east-1"
  #    key    = "terraform.tfstate"
  #  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_instance" "EC2_instance" {
  ami           = "ami-0182f373e66f89c85"
  instance_type = "t2.nano"
  tags = {
    Name = "EC2_instance"
  }
}