#!/bin/bash
# Alejandro Adell Pina :735061


if [[ $UID != 0 ]]
	then
		echo  "Este script necesita privilegios de administracion"
		exit 1
fi

echo "Introduzca los siguientes datos:
nombreGrupoVolumen,nombreVolumenLogico,tamaño,tipoSistemaFicheros,directorioMontaje"

read nombreGrupoVolumen nombreVolumenLogico tamano tipoSistemaFicheros directorioMontaje

if [ -z "$nombreGrupoVolumen" ] | [ -z "$nombreVolumenLogico" ] | [ -z "$tamano" ] | [ -z "$tipoSistemaFicheros" ] | [ -z "$directorioMontaje"  ]
	then
		echo "Datos mal introducidos"
		exit 1
fi

lv=$(sudo lvscan | grep "$nombreVolumenLogico")

if [ -z "$lv" ]
	then
		sudo lvcreate -L $tamano --name $nombreVolumenLogico $nombreGrupoVolumen
		sudo mkfs -t $tipoSistemaFicheros /dev/$nombreGrupoVolumen/$nombreVolumenLogico
		sudo mount -t $tipoSistemaFicheros /dev/$nombreGrupoVolumen/$nombreVolumenLogico $directorioMontaje
	else
		sudo lvextend -L+$tamano /dev/$nombreGrupoVolumen/$nombreVolumenLogico
		sudo resize2fs /dev/$nombreGrupoVolumen/$nombreVolumenLogico
		sudo mount -t $tipoSistemaFicheros /dev/$nombreGrupoVolumen/$nombreVolumenLogico $directorioMontaje
fi







