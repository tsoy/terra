provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "my-book-instance" {
  ami = "ami-05d72852800cbf29e"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-book-example"
  }
}
