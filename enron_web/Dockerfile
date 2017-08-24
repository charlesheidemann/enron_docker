FROM openjdk:8-jre-alpine
MAINTAINER Charles Heidemann <charles.heidemann@gmail.com>
ENV ARTIFACT_NAME=app.jar
ENV SERVER_PORT=9000
ENV ES_HOST=127.0.0.1
ENV ES_PORT=9300
ENV ES_CLUSTER=elasticsearch
ENV JAVA_OPTS=-Dserver.port=$SERVER_PORT -Delasticsearch.host=$ES_HOST -Delasticsearch.port=$ES_PORT -Delasticsearch.clustername=$ES_CLUSTER
ENV APP_OPTS=
COPY ./entrypoint.sh /entrypoint.sh  
COPY ./enron_web.jar /$ARTIFACT_NAME         
EXPOSE $SERVER_PORT
USER root
ENTRYPOINT ["/entrypoint.sh"] 