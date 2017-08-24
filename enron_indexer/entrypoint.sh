#!/bin/sh

# Enables application to take PID 1 and receive SIGTERM sent by Docker stop command.
# See here https://docs.docker.com/engine/reference/builder/#/entrypoint
exec java $JAVA_OPTS \
       -Djava.security.egd=file:/dev/./urandom -jar $ARTIFACT_NAME \
       -i $ENV INPUT_FILE \
       -e $ES_HOST \
       -c $ENV MAX_CONNECTION \ 
       -v $ENV VERBOSE