provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "my-book-instance" {
  ami = "ami-05d72852800cbf29e"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.for-book-instance.id]

  user_data = <<EOF
          #!/bin/bash
          amazon-linux-extras install nginx1 -y
          echo 'Hello' > /usr/share/nginx/html/index.html
          systemctl start nginx
          echo 'Nice'
          EOF

  tags = {
    Name = "terraform-book-example"
  }
}

resource "aws_security_group" "for-book-instance" {
  name = "HTTP and SSH"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
