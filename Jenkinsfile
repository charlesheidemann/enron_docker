pipeline {
    
    agent any
    
    options {
        disableConcurrentBuilds()
        timestamps()
        timeout(time: 5, unit: 'HOURS')
    }

    parameters {
        string(
            name: 'DOCKER_HOST_IP',
            description: 'Docker Host IP',
            defaultValue: '192.168.2.20'
        )
        string(
            name: 'DOCKER_TCP_PORT',
            description: 'Docker host TCP port',
            defaultValue: '2375'
        )
        string(
            name: 'NEXUS_URL',
            description: 'Nexus base URL',
            defaultValue: 'http://192.168.2.20:8001/nexus'
        )
        string(
            name: 'POSTMAN_ENVIRONMENT',
            description: 'Postman environment configuration',
            defaultValue: 'local.postman_environment.json'
        )
    }

    environment {
        DOCKER_HOST_URL = "tcp://${DOCKER_HOST_IP}:${DOCKER_TCP_PORT}"
        URL_ENRON_INDEXER = "${NEXUS_URL}/service/local/artifact/maven/redirect?r=snapshots&g=com.enron.indexer&a=enron_indexer&v=LATEST"
        URL_ENRON_WEB = "${NEXUS_URL}/service/local/artifact/maven/redirect?r=snapshots&g=com.enron.web&a=enron_web&v=LATEST"
    }

    stages {
    
        stage('Preparation') {
            steps {
                sh "curl -o ./enron_indexer/enron_indexer.jar -L '${URL_ENRON_INDEXER}'"
                sh "curl -o ./enron_web/enron_web.jar -L '${URL_ENRON_WEB}'"
            }
        }

        stage("Start SlasticSearch container") {
            steps {
                script {
                    docker.withServer("${DOCKER_HOST_URL}") {
                        esContainer = docker.image('elasticsearch:2.4.5-alpine').run('-p 9200:9200 -p 9300:9300');
                        sleep 5
                    }
                }
            }
        }

        stage("Create Enron Indexer Container") {
            steps {
                script {
                    docker.withServer("${DOCKER_HOST_URL}") {
                        indexerImage = docker.build("enron_indexer", "./enron_indexer");
                    }
                }
            }
        }

        stage("Run Enron Indexer Container") {
            steps {
                script {
                    docker.withServer("${DOCKER_HOST_URL}") {
                        indexerImage.withRun('-e ES_HOST=http://${DOCKER_HOST_IP}:9200') {c ->
                            sleep 5
                            sh "docker logs ${c.id}"
                        }
                    }
                }
            }
        }

        stage("Create Enron Web Container") {
            steps {
                script {
                    docker.withServer("${DOCKER_HOST_URL}") {
                        webImage = docker.build("enron_web", "./enron_web");
                    }
                }
            }
        }

        stage("Run Enron Web Container") {
            steps {
                script {
                    docker.withServer("${DOCKER_HOST_URL}") {
                        webContainer = webImage.run('-p 9000:9000 -e ES_HOST=${DOCKER_HOST_IP}');
                        sleep 5
                        sh "docker logs ${webContainer.id}"
                    }
                }
            }
        }

        stage("Run Postman Tests") {
            steps {
                script {
                    sh "newman run ./enron_web/enron.postman_collection.json -e ./enron_web/${POSTMAN_ENVIRONMENT} -r html"
                }
                archiveArtifacts artifacts: 'newman/*.html'
            }
        }

        stage("Waiting for user...") {
            steps {
                input 'Continue?'
            }
        }
    }

    post {
        always {
            cleanWs()
            script {
                docker.withServer("${DOCKER_HOST_URL}") {
                    try {
                        webContainer.stop();
                    }
                    catch (e) {
                        echo 'Fail to stop Enron Web Container!'
                    }
                    try {
                        esContainer.stop();
                    }
                    catch (e) {
                        echo 'Fail to stop ElasticSearch Container!'
                    }
                }
            }
        }
    }
}