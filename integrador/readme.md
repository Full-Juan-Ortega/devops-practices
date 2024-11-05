# Ejercicio 3 - Depliegue de Minikube y Jenkins en AWS
Necesitaremos un minikube para administrar contenedores en la nube de AWS, para esto el equipo estaba pensando posibilidades de tipos
de instancias para poder administrar la carga de trabajo de minikube.
Una vez realizado vamos a necesitar desplegar un jenkins (en el mismo minikube o en una instancia diferente) y que este para poder
interactuar con el cluster.
Tambien opcionalmente necesitamos exponer el dashboard de recursos de Kubernetes, esto para poder observar las cargas y metricas.

# RESUMEN :
- Crear una ec2 , la clave ssh y el sg.
- instalar docker
- instalar minikube y kubectl.
- archivos yaml para kubernetes. (servicio , deployment y volumen)
- exponer el puerto para poder acceder publicamente a jenkins.
- instalacion del dashboard de k8s (acceso local).

# Proceso

## Ec2 y Requerimentos de minikube.

* En el proceso de levantar la ec2 , levante primero una t2.micro.
* Tuve un error relativo a que minikube necesitaba al menos 2 procesadores asique despues la upgradie a t3.small.
* Luego me paso lo mismo con la ram asique verifique ne la documentacion oficial y termine utilizando una t3.medium.
* Tuve que agrandar el espacio de almacenamiento que tenia la ec2.
* Asigne una ip elastica a la ec2 para que sea siempre el mismo ip.

Requerimentos :  
<https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download>
 


## ssh
Comandos que utilice para acceder via ssh a la ec2.  
cd integrador/3-ej  
ssh -i "ej-02.pem" ubuntu@ec2-34-229-103-35.compute-1.amazonaws.com  

### Instalacion de docker.
instalacion de docker
- sudo apt update -y
- sudo apt install docker.io -y
- sudo docker run hello-world
- sudo usermod -aG docker $USER
- newgrp docker

### Security group.
Cree la primer regla de entrada y la testie con un container de jenkins.  
docker run -d -p 8080:8080 --name jenkins -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

### Instalacion de minikube.
- curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
- sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
- sudo minikube start
- sudo snap install kubectl --classic
- sudo minikube get all

### Manifiestos yaml para kubernetes.
Aqui estan los archivos .yaml de kubernetes.  
<https://github.com/Full-Juan-Ortega/devops-practices/tree/main/integrador/kubernetes>

## Copiar archivos .yaml
Copie los archivos yaml que cree en mi local a la ec2.  
scp -i "ej-02.pem" -r /home/juan/integrador/3-ej/kubernetes ubuntu@ec2-34-229-103-35.compute-1.amazonaws.com:/home/ubuntu


### jenkins pod y exposicion publica.
Aca utilice un servicio nodeport y un port-forward para poder acceder a jenkins publicamente.  
Vi dos maneras de hacerlo ( con los yaml o con comandos con argumentos)  
1. Enfoque declarativo.(con archivos yaml)  
- cd kubernetes
- kubectl apply -f .
- kubectl port-forward svc/jenkins 30000:8080 --address 0.0.0.0 &
2. Enfoque imperativo.(comandos con argumentos)  
- kubectl run jenkins --image=jenkins/jenkins:lts --port=8080
- kubectl port-forward pod/jenkins 8080:8080 (ver para que quede en segundo plano)
.

### Config jenkins.

- kubectl exec -it jenkins -- cat /var/jenkins_home/secrets/initialAdminPassword
- kubectl port-forward svc/jenkins 30000:30000 --address 0.0.0.0 &


### dashboard de kubernetes.(no lo expuse publicamente)
Este comando te permite ingresar al dashboard de kubernetes atraves del navegador.  
minikube dashboard





## Problemas inesperados : 
- La ec2 gratuita es muy chiquita para minikube ( mas de 1 procesador necesita ).  
- Me quede sin espacio de almacenamiento ( tenia solo 8 gb ).  
- Con 2 gb de ram , tampoco funciona , necesita mas asique dado que necesita 2gb de ram exclusivos para minikube.  
- Cambie a una t3.medium con 4gb de ram.  
- tuve que reinstalar minikube al cambiar las instancias. ( quedaba colgado en problemas relativos al hardware).  
- Hice una prueba con docker para ver el security group que configure funcionaba , y si funcionaba.  
- La exposicion de un pod de minikube a una ip publica me parecio bastante compleja , tuve que hacer un nodeport + port-forward.

