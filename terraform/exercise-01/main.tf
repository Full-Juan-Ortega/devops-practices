provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ngnix-server" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t3.micro"
  tags = {
    Name = "ngnix-server"
  }
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOF

  depends_on = [aws_key_pair.nginx-server-ssh-key]
  key_name   = aws_key_pair.nginx-server-ssh-key.key_name 

  vpc_security_group_ids = [aws_security_group.nginx-sg-juan.id]
}


resource "aws_key_pair" "nginx-server-ssh-key" {  
  key_name   = "nginx-server-ssh-key"
  public_key = file("nginx-server.pub")
}

resource "aws_s3_bucket" "example897651321564" {
  bucket = "juan-ejercicio-tf"  # Asegúrate de que el nombre sea único a nivel global
}

resource "aws_security_group" "nginx-sg-juan" {
  name        = "nginx-sg"
  description = "Allow inbound traffic on port 80 and 22"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//practicing outputs

output "ip-address" {
  description = "The public IP address of the web server"
  value = aws_instance.ngnix-server.public_ip
}

output "ssh-command" {
  description = "The command to connect to the web server"
  value = "ssh -i ~/.ssh/nginx-server.pem ubuntu@${aws_instance.ngnix-server.public_ip}"
}

output "bucket-name" {
  description = "The name of the S3 bucket"
  value = aws_s3_bucket.example897651321564.bucket
}
