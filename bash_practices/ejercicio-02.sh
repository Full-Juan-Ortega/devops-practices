#!/bin/bash

# Obtener los datos del sistema
user_name=$(whoami)
user_home=$(echo $HOME)
default_shell=$(echo $SHELL)


#Archivo JSON de salida

output_file="${user_name}_system_info.json"

# Crear el archivo JSON con la información
cat <<bloqueJson > $output_file
{
  "user_name": "$user_name",
  "user_home": "$user_home",
  "default_shell": "$default_shell"
}
bloqueJson



# Mostrar el contenido del archivo JSON en la consola
cat $output_file
