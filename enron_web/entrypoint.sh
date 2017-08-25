#!/bin/sh
java -Dserver.port=$SERVER_PORT -Delasticsearch.host=$ES_HOST -Delasticsearch.port=$ES_PORT -Delasticsearch.clustername=$ES_CLUSTER -Djava.security.egd=file:/dev/./urandom -jar $ARTIFACT_NAME
