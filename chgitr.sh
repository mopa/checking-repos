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

    # Comprobamos si tiene remoto
    if [ $(git remote | grep fatal -c) -ne 0 ]
    then
      echo "No tiene remoto"
    else
      echo "Si tiene remoto"
    fi

  else
    echo "No es un Repositorio"
  fi

done < git_dirs.txt
