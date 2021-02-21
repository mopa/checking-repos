#!/bin/bash
#
# Comprobar el estado de los repositorios Git
#

# Colores
blue="\e[0;94m"
purple="\e[0;35m"
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
      echo -en "\033[0;31m"
      echo "Ficheros modificados"
      echo -en "\033[0m"
    fi

    # Comprobamos los ficheros que no estan es seguimiento
    if [ $(git status | grep Untracked -c) -ne 0 ]
    then
      var=1
      echo -en "\033[0;31m"
      echo "Ficheros sin seguimiento"
      echo -en "\033[0m"
    fi

    # Comprobamos si no hay commit
    if [ $(git status | grep 'Your branch is ahead' -c) -ne 0 ]
    then
      var=1
      echo -en "\033[0;31m"
      echo "Falta el commit"
      echo -en "\033[0m"
    fi

    # Comprobamos si estado Ok
    if [ $var -eq 0 ]
    then
      echo "Todo esta OK"
    fi

  else
    echo "No es un Repositorio"
  fi

done < git_dirs.txt
