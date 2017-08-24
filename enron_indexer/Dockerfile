FROM openjdk:8-jre-alpine

MAINTAINER Charles Heidemann <charles.heidemann@gmail.com>

ENV WORK_DIR=/work
ENV ARTIFACT_NAME=app.jar
ENV INPUT_FILE=enron.json
ENV VERBOSE=false
ENV ES_HOST=127.0.0.1:9200
ENV MAX_CONNECTION=25
ENV JAVA_OPTS=

COPY ./enron_indexer.jar $WORK_DIR/$ARTIFACT_NAME
COPY ./enron.json $WORK_DIR/$INPUT_FILE
COPY ./entrypoint.sh $WORK_DIR/entrypoint.sh  

USER root

RUN chmod +x $WORK_DIR/entrypoint.sh
RUN cat $WORK_DIR/entrypoint.sh

WORKDIR $WORK_DIR

ENTRYPOINT ["./entrypoint.sh"]