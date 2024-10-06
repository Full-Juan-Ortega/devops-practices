#!/bin/bash
#Actualizar
echo "inicio del script"
sudo apt update -y
sudo apt upgrade -y
sudo apt install curl git
#Instalar.
echo "comenzamos las instalaciones"
sudo apt install python3
echo "finalizo python"
sudo apt install snapd
sudo snap refresh
echo "finalizo snap"
sudo snap install node --classic
echo "finalizo node"
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "finalizo instalacion y agregada variable de entorno"
echo "Version de node instalada"
node -v
echo "Version de Python3 instalada"
python3 --version
echo "Snap ha sido instalado"
snap
echo "Brew ha sido instalado"
brew
