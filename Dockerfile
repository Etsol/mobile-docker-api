# Back-End - Dockerfile
#
# VERSION               0.0.1

FROM java:8

MAINTAINER Bruno Reato

#Entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
