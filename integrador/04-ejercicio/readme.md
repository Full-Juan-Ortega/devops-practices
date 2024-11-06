# Caso 4  
- Pipeline para el despliegue de IaC de Terraform via Jenkins
Vamos a necesitar un pipeline que despliegue IaC que anteriormente habiamos importado (Caso 2) utilizando Jenkins. Ademas de los recursos anteriores, tambien vamos a necesitar son los siguientes.  
- IAM Role con permisos para acceder a la vpc-node-app, permisos para acceder al bucket de s3 node-app-backup
- S3 con versionamiento llamado con el prefix: node-app-logs-*
NOTA: Este pipeline debera utilizar el state remoto del Caso 2

## dependencias : 
- Instale terraform segun la doc oficial :  
<https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli>  


### jenkins
exponer jenkins publicamente en el puerto 30000 :  
kubectl port-forward svc/jenkins 30000:30000 --address 0.0.0.0 &

datos de jenkins : 
url : http://44.210.52.58:30000/  
user : juan  
password : 1234  

### conseguir los archivos de tf del caso 2.
Para esto tuve que copiar solo la carpeta que necesitaba dentro del repositorio en el que habia guardado la carpeta del ejercicio2.

git clone --no-checkout https://github.com/Full-Juan-Ortega/devops-practices.git
git sparse-checkout init --cone
git sparse-checkout set terraform/integrador-ej-02
git checkout main

### agregar el iam role y el s3.




### jenkins pipeline.

# comandos

`ssh -i "ej-02.pem" ubuntu@ec2-44-210-52-58.compute-1.amazonaws.com`
kubectl port-forward svc/jenkins 30000:30000 --address 0.0.0.0 &
kubectl exec -it jenkins-757cdf4c64-8rh8t -- cat /var/jenkins_home/secret
s/initialAdminPassword