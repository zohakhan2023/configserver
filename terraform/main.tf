terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      region  = "us-east-1"
    }
  }
}
  resource "aws_instance" "EC2_instance" {
    ami           = "ami-0b0ea68c435eb488d"
    instance_type = "t2.micro"
    tags = {
      Name = "EC2_instance"
    }
  }
