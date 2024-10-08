


module "nginx_server_qa" {
    source = "./modules"

    server_name      = "nginx-server-qa"
    environment      = "qa"
}


output "nginx_qa_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = module.nginx_server_qa.server_public_ip
}

output "nginx_qa_dns" {
  description = "DNS público de la instancia EC2"
  value       = module.nginx_server_qa.server_public_dns
}