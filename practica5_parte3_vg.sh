#!/bin/bash
# Alejandro Adell Pina :735061


if [[ $UID != 0 ]]
	then
		echo  "Este script necesita privilegios de administracion"
		exit 1
fi

grupo=$(sudo vgscan | grep "$1")

if [ -z "$grupo" ]
	then
		echo "No existe el VG"
	else	
		for i in $@
		do	
			if [ $i != $1 ]
				then
					sudo vgextend -y $1 $i
			fi
		done
fi
