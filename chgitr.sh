#!/bin/bash
#
# Script para comprobar el estado de los Respositorios
#
# Version: 0.1
# Author: Pablo M.
#
######################################################


# Colores
blue="\e[0;94m"
purple="\e[0;35m"
red="\e[0;31m"
green="\e[0;92m"
reset="\e[0m"

# Limpiamos la pantalla
clear

# Vamos a ir comprobando el estado de los directorios
while IFS= read -r line; do
  SDIR=$HOME/$line

  echo ''
  echo -e "${purple}******************************************************${reset}"
  echo -e "${blue}Directorio:${reset}" "$SDIR"
  cd $SDIR 

  if [ -d "$SDIR/.git" ] 
  then

    # Variable de testeo
    var=0

    # Comprobamos si tiene remoto
    if [ $(git remote | grep "" -c) -ne 0 ]
    then
      echo "Si tiene remoto"
    else
      echo "No tiene remoto"
    fi

    # Comprobamos los ficheros modificados
    if [ $(git status | grep modified -c) -ne 0 ]
    then
      var=1
      echo -e "${red}Ficheros modificados${reset}"
    fi

    # Comprobamos los ficheros que no estan es seguimiento
    if [ $(git status | grep Untracked -c) -ne 0 ]
    then
      var=1
      echo -e "${red}Ficheros sin seguimiento${reset}"
    fi

    # Comprobamos si no hay commit
    if [ $(git status | grep 'Your branch is ahead' -c) -ne 0 ]
    then
      var=1
      echo -e "${red}Falta el commit${reset}"
    fi

    # Comprobamos si estado Ok
    if [ $var -eq 0 ]
    then
      echo -e "${green}Todo esta OK${reset}"
    fi

  else
    echo "No es un Repositorio"
  fi

done < gitdirs.txt
