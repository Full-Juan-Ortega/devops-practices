#syntax=docker/dockerfile:1
FROM ubuntu:22.04

RUN apt update && \
    apt install -y \
    net-tools \ #Comando ifconfig
    arp-scan \ #Comando arp-scan --localnet
    openssh-client \ #Comando ssh user@ip
    tree \ #Comando tree
    python3 #Comando python3

#set the working directory (optional)
WORKDIR /app

# Agregar un mensaje de éxito
RUN echo "Construcción de la imagen Docker completada con éxito!"

# Add any additional setup or commands here

# Default command (optional)
CMD [ "bash" ]
