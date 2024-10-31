minikube start
#crear la carpeta /mnt/data2 y dar permisos.
minikube ssh
#comando que crea y da permisos.
sudo install -d -m 777 /mnt/data3
kubectl apply -f 01-namespace.yaml
kubectl config set-context --current --namespace=mi-app
kubectl apply -f .