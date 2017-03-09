#!/bin/bash

function start {
		echo "********>> Starting"
        cd /home/api/build/libs
        java -jar -Xms${MIN_MEM}m -Xmx${MAX_MEM}m -Dspring.datasource.url=jdbc:mariadb://$IP_DB:3306/$NAME_DB?createDatabaseIfNotExist=1 -Dspring.datasource.username=root -Dspring.datasource.password=$PASS_DB -Dserver.port=8080 -Dlogging.file=/var/log/bbjetmobile-$NAME_DB.log bbjet-mobile-api-*.jar
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
