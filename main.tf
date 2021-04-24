provider "aws" {
  region = "us-east-2"
}
variable "web_server_port" {
  description = "The port web server will use for HTTP requests"
  type = number
  default = 8080
}

resource "aws_instance" "my-book-instance" {
  ami = "ami-05d72852800cbf29e"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.for-book-instance.id
  ]

  user_data = <<EOF
          #!/bin/bash
          amazon-linux-extras install nginx1 -y
          echo 'Hello' > /usr/share/nginx/html/index.html
          sed -i 's/80/${var.web_server_port}/' /etc/nginx/nginx.conf
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
    from_port = var.web_server_port
    to_port = var.web_server_port
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

output "public_ip" {
  value = aws_instance.my-book-instance.public_ip
  description = "Public IP of the web server"
}
