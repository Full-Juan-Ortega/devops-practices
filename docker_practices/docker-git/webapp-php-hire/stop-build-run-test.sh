#!/bin/bash

docker stop $(docker ps -lq);
docker build -t phpapp:debian-php .;
docker run -d -p 443:443 phpapp:debian-php;
curl -v https://localhost:443 --insecure
echo "CURL NORMAL"
curl https://localhost:443
