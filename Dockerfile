# Back-End - Dockerfile
#
# VERSION               0.0.1

FROM java:8u111-alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache tzdata unzip

RUN cp /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
RUN echo "America/Argentina/Buenos_Aires" >  /etc/timezone

#Entrypoint
ADD entrypoint.sh /entrypoint.sh
ADD download-version.sh /download-version.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /download-version.sh
RUN dos2unix /entrypoint.sh
RUN dos2unix /download-version.sh
ENTRYPOINT ["/entrypoint.sh"]
