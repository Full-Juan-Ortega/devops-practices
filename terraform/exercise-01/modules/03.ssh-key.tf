resource "aws_key_pair" "nginx-server-ssh-key" {  
  key_name   = "${var.server_name}-ssh-key"
  public_key = file("${var.server_name}.pub")
}