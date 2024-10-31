# ===========<---- Los outputs nos permiten ver el valor de los datos despues de hacer el apply ---->===========#

output "server_public_ip" {
  description = "The public IP address of the web server"
  value = aws_instance.ngnix-server.public_ip
}

output "server_public_dns" {
  description = "DNS público de la instancia EC2"
  value       = aws_instance.ngnix-server.public_dns
}

output "ssh-command" {
  description = "The command to connect to the web server"
  value = "ssh -i ~/.ssh/nginx-server.pem ubuntu@${aws_instance.ngnix-server.public_ip}"
}
