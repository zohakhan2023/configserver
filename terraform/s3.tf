resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket-update"

  tags = {
    Name = "terraform-state-update"
  }
}

resource "aws_s3_bucket_policy" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.terraform_state.arn}/*"
        Principal = "*"
      }
    ]
  })
}
