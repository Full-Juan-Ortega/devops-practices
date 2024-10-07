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
  value = aws_s3_bucket.bucket-01.bucket
}