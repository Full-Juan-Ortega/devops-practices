provider "aws" {
  region = "us-west-2" # Cambia la región según tu preferencia
}

resource "aws_instance" "mi_instancia_ec2" {
  ami           = "ami-0c55b159cbfafe1f0" # Cambia por la AMI que prefieras
  instance_type = "t3.medium" # 2 vCPUs y 4 GB de RAM

  # Configuración para exponer los puertos
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]

  tags = {
    Name = "mi-ec2"
  }
}