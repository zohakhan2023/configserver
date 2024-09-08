resource "aws_instance" "Zoha_EC2_instance" {
  ami           = "ami-0b0ea68c435eb488d"
  instance_type = "t2.micro"
  tags = {
    Name = "Zoha_EC2_instance"
  }
}