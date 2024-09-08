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


resource "aws_instance" "Zoha_EC2_instance" {
  ami           = "ami-0b0ea68c435eb488d"
  instance_type = "t2.micro"
  tags = {
    Name = "Zoha_EC2_instance"
  }
}