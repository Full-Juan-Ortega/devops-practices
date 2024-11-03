# Ej 03.

Caso 3 - Depliegue de Minikube y Jenkins en AWS
Necesitaremos un minikube para administrar contenedores en la nube de AWS, para esto el equipo estaba pensando posibilidades de tipos
de instancias para poder administrar la carga de trabajo de minikube.
Una vez realizado vamos a necesitar desplegar un jenkins (en el mismo minikube o en una instancia diferente) y que este para poder
interactuar con el cluster.
Tambien opcionalmente necesitamos exponer el dashboard de recursos de Kubernetes, esto para poder observar las cargas y metricas.

# Proceso

## Crear una ec2 e instalar minikube y docker.
- pienso trabajar en una ec2 para instalar docker , minikube y un pod en base a una imagen de jenkins.

## Copiar archivos .yaml
scp -i "ej-02.pem" -r /home/juan/integrador/3-ej/kubernetes ubuntu@ec2-34-229-103-35.compute-1.amazonaws.com:/home/ubuntu

## ssh
cd integrador/3-ej
ssh -i "ej-02.pem" ubuntu@ec2-34-229-103-35.compute-1.amazonaws.com

### Instalacion de docker.
instalacion de docker
- sudo apt update -y
- sudo apt install docker.io -y
- sudo docker run hello-world
- sudo usermod -aG docker $USER
- newgrp docker

docker run -d -p 8080:8080 --name jenkins -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

### Instalacion de minikube.
- curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
- sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
- sudo minikube start
- sudo snap install kubectl --classic
- sudo minikube get all

### jenkins pod y exposicion publica.

1. Enfoque declarativo.(con archivos yaml)
- cd kubernetes
- kubectl apply -f .
- kubectl port-forward svc/jenkins 30000:8080 --address 0.0.0.0 &
2. Enfoque imperativo.(comandos con argumentos)
- kubectl run jenkins --image=jenkins/jenkins:lts --port=8080
- kubectl port-forward pod/jenkins 8080:8080 (ver para que quede en segundo plano)

Para acceder a Jenkins, puedes hacer un port-forward.

### Config jenkins.

- kubectl exec -it jenkins -- cat /var/jenkins_home/secrets/initialAdminPassword
- kubectl port-forward svc/jenkins 30000:30000 --address 0.0.0.0 &
- curl http://34.229.103.35:30000

### Requerimentos de minikube.

- upgradear la instancia.
- ec2 para instalar minikube con caracteristicas : 


### dashboard de kubernetes.(no lo expuse publicamente)
1. Instalar el Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
2. Verificar la Instalación
kubectl get pods -n kubernetes-dashboard
3. Iniciar el Proxy de Kubernetes
kubectl proxy
4. Acceder al Dashboard
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
5. Crear un Token de Acceso (Opcional, pero Recomendado)
```
kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard
kubectl create clusterrolebinding dashboard-admin-binding --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:dashboard-admin
kubectl -n kubernetes-dashboard create token dashboard-admin
```




## Problemas inesperados : 
La ec2 gratuita es muy chiquita para minikube ( mas de 1 procesador necesita )
Me quede sin espacio de almacenamiento ( tenia solo 8 gb )
Con 2 gb de ram , tampoco funciona , necesita mas asique dado que necesita 2gb de ram exclusivos para minikube.
Cambie a una t3.medium con 4gb de ram.
tuve que reinstalar minikube al cambiar las instancias. ( quedaba colgado en problemas relativos al hardware).
Fui avanzando con comandos en el proceso del pod de jenkins, el tema es que al hacer el port forward se empezo a complicar.El port-forward no es como el de docker , no puede usarse fuera del port, para eso necesito un service
Dado esto hare los .yaml.
Hice una prueba con docker para ver el security group que configure funcionaba , y si funcionaba.
Tuve unos problemitas con el port forward, podia acceder a jenkins localmente pero no por la ip publica. Tuve que usar el service y un port-forward.

