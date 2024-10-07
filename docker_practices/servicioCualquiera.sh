#!/bin/bash

minutes=0

# Bucle que cuenta hasta 60 minutos
while [ $minutes -lt 60 ]; do
	    echo "<p>Han pasado $minutes minutos.</p>" > index.html
    	    sleep 60  # Espera 60 segundos
		    minutes=$((minutes + 1))  # Incrementa el contador de minutos
	    done

	    echo "Se han completado 60 minutos."

