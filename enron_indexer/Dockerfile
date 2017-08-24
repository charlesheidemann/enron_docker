FROM openjdk:8-jre-alpine
MAINTAINER Charles Heidemann <charles.heidemann@gmail.com>
ENV ARTIFACT_NAME=app.jar
ENV INPUT_FILE=enron.json
ENV ES_HOST=127.0.0.1:9200
ENV VERBOSE=false
ENV MAX_CONNECTION=25
ENV JAVA_OPTS=
COPY assets/entrypoint.sh /entrypoint.sh  
COPY assets/enron_indexer.jar /$ARTIFACT_NAME         
ENTRYPOINT [\"./entrypoint.sh\"] 