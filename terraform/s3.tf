resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"

  tags = {
    Name = "terraform-state"
  }
}

resource "aws_s3_bucket_acl" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}
