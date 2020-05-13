#!/bin/bash

# Alejandro Adell Pina: 735061


if [ $(id -u) != 0 ]
	then	
		echo "Este script necesita privilegios de administrador"
		exit 1
fi

ssh -q -i /etc/ssh/id_as_ed25519 as@$1 << fin

echo -e  "\n1. Discos duros disponibles y tamaños de bloques:"
sudo sfdisk -s
echo -e "\n2. Particiones y sus tamaños:" 
sudo sfdisk -l | grep /dev
echo -e "\n3. Información de montaje de sistema de ficheros:"
sudo df -hT | grep -v tmpfs
fin
