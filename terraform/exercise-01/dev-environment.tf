provider "aws" {
  region = "us-east-1"
}


####### modulos #######
module "nginx_server_dev" {
    source = "./modules"

    server_name      = "nginx-server-dev"
    environment      = "dev"
}


#######  output ####### 
output "nginx_dev_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = module.nginx_server_dev.server_public_ip
  }

output "nginx_dev_dns" {
  description = "DNS público de la instancia EC2"
  value       = module.nginx_server_dev.server_public_dns
}



# ===========<---- s3 para el tfstate ---->===========#

/* terraform {
  backend "s3" {
    bucket = "juan-bucket-01-prueba"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
} */
 

