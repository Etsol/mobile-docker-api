#!/bin/bash

function run_with_jmx {
   echo "Habilitando jmx..."
   java -jar -Xms${MIN_MEM}m -Xmx${MAX_MEM}m -Dcom.sun.management.jmxremote -Dcom.sun.$
}

function run_without_jmx {
   echo "Corriendo sin jmx"
   java -jar -Xms${MIN_MEM}m -Xmx${MAX_MEM}m -Dspring.datasource.url=jdbc:mariadb://$I$
}

function start {
		echo "********>> Starting"
        cd /home/api/build/libs
        #java -jar -Xms${MIN_MEM}m -Xmx${MAX_MEM}m -Dspring.datasource.url=jdbc:mariadb://$IP_DB:3306/$NAME_DB?createDatabaseIfNotExist=1 -Dspring.datasource.username=root -Dspring.datasource.password=$PASS_DB -Dserver.port=8080 -Dlogging.file=/var/log/bbjetmobile-$NAME_DB.log bbjet-mobile-api-*.jar
        if [[ -z "${ENABLE_JMX}" ]]; then
                run_without_jmx
        else
                if [ "$ENABLE_JMX"="TRUE" ]; then
                        run_with_jmx
                else
                        run_without_jmx
                fi
        fi
}

cd /home/api/build/libs
if [ ! -f bbjet-mobile-api-*.jar ]; then
        echo "********>> Building"
        cd /home/api/
        chmod +x gradlew
        ./gradlew clean
        ./gradlew build
        start
else
        start
fi
