# Configuración del grupo de seguridad
resource "aws_security_group" "sg_ec2" {
  name        = "sg-mi-ec2"
  description = "Grupo de seguridad para abrir puertos 30000 y 8080"

  # Reglas para exponer los puertos
  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # permite todo el tráfico de salida
    cidr_blocks = ["0.0.0.0/0"]
  }
}