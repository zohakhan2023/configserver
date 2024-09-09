resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"
  acl    = "private"

  tags = {
    Name = "terraform-state"
  }
}