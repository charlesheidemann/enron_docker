FROM openjdk:8-jre-alpine
MAINTAINER Charles Heidemann <charles.heidemann@gmail.com>
ENV ARTIFACT_NAME=app.jar
ENV SERVER_PORT=9000
ENV ES_HOST=127.0.0.1
ENV ES_PORT=9300
ENV ES_CLUSTER=elasticsearch
COPY ./entrypoint.sh /entrypoint.sh  
COPY ./enron_web.jar /$ARTIFACT_NAME
RUN chmod +x /entrypoint.sh         
EXPOSE $SERVER_PORT
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]