#!/bin/sh

# Verificar si existe la versión, sino descargarla
./download-version.sh $VERSION

cd /home/api

JAVA_OPTS=

# Si se configuró el parámetro XX agregar parámetro de garbage collector de java
if [[ ! -z "${XX}" ]]; then
   JAVA_OPTS="$JAVA_OPTS $XX"
fi

# Si se configuró el parámetro MIN_MEM configurar la memoria mínima del heap
if [[ ! -z "${MIN_MEM}" ]]; then
   JAVA_OPTS="$JAVA_OPTS -Xms${MIN_MEM}m"
fi

# Si se configuró el parámetro MAX_MEM configurar la memoria máxima del heap
if [[ ! -z "${MAX_MEM}" ]]; then
   JAVA_OPTS="$JAVA_OPTS -Xmx${MAX_MEM}m"
fi

# Si existe la variable de entorno JMX_HOST configurar acceso JMX
if [[ ! -z "${JMX_HOST}" ]]; then
   JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote -Djava.rmi.server.hostname=$JMX_HOST -Dcom.sun.management.jmxremote.port=$JMX_PORT -Dcom.sun.management.jmxremote.rmi.port=$JMX_PORT -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
fi

# Timeout retrofit
if [[ -z "${RETROFIT_TIMEOUT}" ]]; then
   RETROFIT_TIMEOUT=60
fi

ENABLE="${ENABLE:-false}"
if [ $ENABLE != "true" ]; then
   ENABLE="false"
fi

/bin/sh -c "java -jar $JAVA_OPTS -Dspring.datasource.url=jdbc:mariadb://$IP_DB:3306/$NAME_DB?createDatabaseIfNotExist=1 -Dspring.datasource.username=root -Dspring.datasource.password=$PASS_DB -Dserver.port=8080 -Dlogging.file=/home/api/bbjetmobile-$NAME_DB.log -Dretrofit.timeout=$RETROFIT_TIMEOUT -Dbbjetmobile.device.force_enable=$ENABLE /home/api/bbjet-mobile-api-$VERSION-SNAPSHOT.jar"