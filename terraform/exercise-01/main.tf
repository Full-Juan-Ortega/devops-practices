provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the server"
  default = "ami-0866a3c8686eaeeba"
}

variable "instance_type" {
  description = "The type of instance to use for the server"
  default = "t2.micro"
}

variable "server_name" {
  description = "The name of the server"
  default = "nginx-server"
}

variable "environment" {
  description = "The environment of the server"
  default = "dev"
}



# ===========<---- Los outputs nos permiten ver el valor de los datos despues de hacer el apply ---->===========#

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


resource "aws_instance" "ngnix-server" {

  tags = {
    Environment = var.environment
    Name        = var.server_name
    Owner       = "Juan-Devops"
    Project     = "Terraform"
  }

  ami           = var.ami_id//"ami-0866a3c8686eaeeba"
  instance_type = var.instance_type
  
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOF

  depends_on = [aws_key_pair.nginx-server-ssh-key]
  key_name   = aws_key_pair.nginx-server-ssh-key.key_name 

  vpc_security_group_ids = [aws_security_group.nginx-server-sg.id]
}


resource "aws_key_pair" "nginx-server-ssh-key" {  
  key_name   = "${var.server_name}-ssh-key"
  public_key = file("${var.server_name}.pub")
}

resource "aws_s3_bucket" "example897651321564" {
  bucket = "juan-ejercicio-tf"  # Asegúrate de que el nombre sea único a nivel global
}

resource "aws_security_group" "nginx-server-sg" {
  name        = "${var.server_name}-juan"
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


