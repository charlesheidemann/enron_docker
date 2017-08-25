FROM openjdk:8-jre-alpine

MAINTAINER Charles Heidemann <charles.heidemann@gmail.com>

ENV WORK_DIR=/work
ENV ARTIFACT_NAME=app.jar
ENV SERVER_PORT=9000
ENV ES_HOST=127.0.0.1
ENV ES_PORT=9300
ENV ES_CLUSTER=elasticsearch

COPY ./enron_web.jar $WORK_DIR/$ARTIFACT_NAME
COPY ./entrypoint.sh $WORK_DIR/entrypoint.sh  

USER root

RUN chmod +x $WORK_DIR/entrypoint.sh

WORKDIR $WORK_DIR

EXPOSE $SERVER_PORT

ENTRYPOINT ["./entrypoint.sh"]