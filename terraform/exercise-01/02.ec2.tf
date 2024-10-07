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