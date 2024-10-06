

FROM debian:10
RUN \
	apt -y update && \
	apt -y install apache2 && \
	apt -y install php php-cli php-common
	

RUN echo "Hello World" > /var/www/html/index.html

COPY server.crt /etc/ssl/certs/server.crt
COPY server.key /etc/ssl/private/server.key
#Habilita el Virtual Host
RUN cat <<EOF > /etc/apache2/sites-available/default-ssl.conf
<IfModule mod_ssl.c>
    <VirtualHost *:443>
        ServerAdmin admin@tu-dominio.com
        ServerName localhost
        DocumentRoot /var/www/html

        SSLEngine on

        SSLCertificateFile /etc/ssl/certs/server.crt
        SSLCertificateKeyFile /etc/ssl/private/server.key
    </VirtualHost>
</IfModule>
EOF
RUN a2enmod ssl


EXPOSE 443:443

CMD ["apachectl", "-D", "FOREGROUND"]


