pipeline {
    agent any

    environment {
        DOCKER_PROJECT_NAME = "odh-vkg"
        DOCKER_IMAGE_ONTOP = "755952719952.dkr.ecr.eu-west-1.amazonaws.com/odh-vkg-ontop"
        DOCKER_IMAGE_NGINX = "755952719952.dkr.ecr.eu-west-1.amazonaws.com/odh-vkg-nginx"
        DOCKER_TAG = "prod-$BUILD_NUMBER"

        SERVER_PORT = "1008"
        ONTOP_QUERY_TIMEOUT = 15

        // We use the IP now, because the lookup of "prod-postgres-tourism-2.co90ybcr8iim.eu-west-1.rds.amazonaws.com"
        // might not always work or take too long and thus we get timeouts.
        ORIGINAL_POSTGRES_HOST = "52.210.97.235"
        ORIGINAL_POSTGRES_DB = "tourism"
        ORIGINAL_POSTGRES_USER = "vkgreplicate"
        ORIGINAL_POSTGRES_PASSWORD = credentials('it.bz.opendatahub.sparql.db.tourism.password')
        COPY_POSTGRES_HOST = "prod-postgres-vkgreplication.co90ybcr8iim.eu-west-1.rds.amazonaws.com"
        COPY_POSTGRES_DB = "tourism_prod"
        COPY_POSTGRES_USER = "vkguser"
        COPY_POSTGRES_PASSWORD = credentials('it.bz.opendatahub.sparql.db.vkg.password')
        COPY_POSTGRES_USER_READONLY = "vkguser_readonly"
        COPY_POSTGRES_PASSWORD_READONLY = credentials('it.bz.opendatahub.sparql.db.vkg.password.readonly')

        FLYWAY_URL = "jdbc:postgresql://${COPY_POSTGRES_HOST}/${COPY_POSTGRES_DB}"
        FLYWAY_USER = "${COPY_POSTGRES_USER}"
        FLYWAY_PASSWORD = "${COPY_POSTGRES_PASSWORD}"
        FLYWAY_PLACEHOLDERS_ORIGINAL_HOST = "${ORIGINAL_POSTGRES_HOST}"
        FLYWAY_PLACEHOLDERS_ORIGINAL_DB = "${ORIGINAL_POSTGRES_DB}"
        FLYWAY_PLACEHOLDERS_ORIGINAL_USER = "${ORIGINAL_POSTGRES_USER}"
        FLYWAY_PLACEHOLDERS_ORIGINAL_PASSWORD = "${ORIGINAL_POSTGRES_PASSWORD}"
        FLYWAY_PLACEHOLDERS_SUBSCRIPTION_NAME = "tourism_prod_subscription"
        FLYWAY_PLACEHOLDERS_PUBLICATION_NAME = "vkgpublication"
        FLYWAY_PLACEHOLDERS_COPY_USER_READONLY = "${COPY_POSTGRES_USER_READONLY}"
    }

    stages {
        stage('Configure') {
            steps {
                sh '''
                    rm -f .env
                    echo "COMPOSE_PROJECT_NAME=${DOCKER_PROJECT_NAME}" >> .env
                    echo "DOCKER_IMAGE_ONTOP=${DOCKER_IMAGE_ONTOP}" >> .env
                    echo "DOCKER_IMAGE_NGINX=${DOCKER_IMAGE_NGINX}" >> .env
                    echo "DOCKER_TAG=${DOCKER_TAG}" >> .env

                    echo "SERVER_PORT=${SERVER_PORT}" >> .env

                    echo "COPY_POSTGRES_HOST=${COPY_POSTGRES_HOST}" >> .env
                    echo "COPY_POSTGRES_DB=${COPY_POSTGRES_DB}" >> .env
                    echo "COPY_POSTGRES_USER=${COPY_POSTGRES_USER}" >> .env
                    echo "COPY_POSTGRES_PASSWORD=${COPY_POSTGRES_PASSWORD}" >> .env

                    echo "FLYWAY_URL=${FLYWAY_URL}" >> .env
                    echo "FLYWAY_USER=${FLYWAY_USER}" >> .env
                    echo "FLYWAY_PASSWORD=${FLYWAY_PASSWORD}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_ORIGINAL_HOST=${FLYWAY_PLACEHOLDERS_ORIGINAL_HOST}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_ORIGINAL_DB=${FLYWAY_PLACEHOLDERS_ORIGINAL_DB}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_ORIGINAL_USER=${FLYWAY_PLACEHOLDERS_ORIGINAL_USER}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_ORIGINAL_PASSWORD=${FLYWAY_PLACEHOLDERS_ORIGINAL_PASSWORD}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_SUBSCRIPTION_NAME=${FLYWAY_PLACEHOLDERS_SUBSCRIPTION_NAME}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_PUBLICATION_NAME=${FLYWAY_PLACEHOLDERS_PUBLICATION_NAME}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_COPY_USER_READONLY=${FLYWAY_PLACEHOLDERS_COPY_USER_READONLY}" >> .env

                    sed -i -e "s%\\(jdbc.url\\s*=\\).*\\$%\\1jdbc\\\\\\\\:postgresql\\\\\\\\://${COPY_POSTGRES_HOST}/${COPY_POSTGRES_DB}%" vkg/odh.docker.properties
                    sed -i -e "s%\\(jdbc.user\\s*=\\).*\\$%\\1${COPY_POSTGRES_USER_READONLY}%" vkg/odh.docker.properties
                    sed -i -e "s%\\(jdbc.password\\s*=\\).*\\$%\\1${COPY_POSTGRES_PASSWORD_READONLY}%" vkg/odh.docker.properties
                    sed -i -e "s%\\(ontop.query.defaultTimeout\\s*=\\).*\\$%\\1${ONTOP_QUERY_TIMEOUT}%" vkg/odh.docker.properties
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                    aws ecr get-login --region eu-west-1 --no-include-email | bash
                    docker-compose --no-ansi -f infrastructure/docker-compose.build.yml build --pull
                    docker-compose --no-ansi -f infrastructure/docker-compose.build.yml push
                '''
            }
        }
        stage('Deploy') {
            steps {
               sshagent(['jenkins-ssh-key']) {
                    sh """
                        (cd infrastructure/ansible && ansible-galaxy install -f -r requirements.yml)
                        (cd infrastructure/ansible && ansible-playbook --limit=prod deploy.yml --extra-vars "release_name=${BUILD_NUMBER}")
                    """
                }
            }
        }
    }
}
