#!/bin/sh

MOBILE_BASE_PATH=/home/api
VERSION_PATH=$MOBILE_BASE_PATH
JAR_VERSION_FILENAME=bbjet-mobile-api-$1-SNAPSHOT.jar
VERSION_ZIP_FILE=bbjet-mobile-api-$1.zip

echo "---------------------------------------------------------------------"
echo "           Chequeando la version $1 de bbjet-mobile-api              "
echo "---------------------------------------------------------------------"

if [ $# == 0 ]
then
   echo "ERROR: Debe indicar la versión a instalar"
   exit 1
fi

mkdir -p $VERSION_PATH

if [ ! -f $VERSION_PATH/$JAR_VERSION_FILENAME ] 
then
   echo "No se encontró la versión. Descargando...."

   cd $VERSION_PATH

   if [ -f $VERSION_ZIP_FILE ]; then
      rm $VERSION_ZIP_FILE
   fi

   wget http://$USUARIO:$PASSWORD@$URL_MOBILE_API_REPOS/$VERSION_ZIP_FILE
   unzip -o -j $VERSION_ZIP_FILE build/libs/bbjet-mobile-api-$1-SNAPSHOT.jar

   if [ ! -d $VERSION_PATH/config ]; then
      echo "No se encontro la configuracion del backend. Se descargara la por defecto"
      unzip $VERSION_ZIP_FILE scripts/*
   fi

   rm $VERSION_ZIP_FILE

   chmod +x $VERSION_PATH/$JAR_VERSION_FILENAME
fi
