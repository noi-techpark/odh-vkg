pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = "odh-vkg"
        DOCKER_IMAGE_ONTOP = "755952719952.dkr.ecr.eu-west-1.amazonaws.com/odh-vkg-ontop"
        DOCKER_IMAGE_NGINX = "755952719952.dkr.ecr.eu-west-1.amazonaws.com/odh-vkg-nginx"
        DOCKER_TAG = "prod-$BUILD_NUMBER"
		ANSIBLE_LIMIT = "prod"

        SERVER_PORT = "1008"
        ONTOP_QUERY_TIMEOUT = 15

        // TOURISM TEST DB
        FLYWAY_PLACEHOLDERS_TOURISM_DB = "tourism"
        FLYWAY_PLACEHOLDERS_TOURISM_HOST = "prod-postgres-tourism-2.co90ybcr8iim.eu-west-1.rds.amazonaws.com"
        FLYWAY_PLACEHOLDERS_TOURISM_USER = "vkgreplicate"
        FLYWAY_PLACEHOLDERS_TOURISM_PASSWORD = credentials('it.bz.opendatahub.sparql.db.tourism.password')
        FLYWAY_PLACEHOLDERS_TOURISM_PUBLICATION_NAME = "vkgpublication"
        FLYWAY_PLACEHOLDERS_TOURISM_SUBSCRIPTION_NAME = "tourism_test_subscription"
        FLYWAY_PLACEHOLDERS_TOURISM_SCHEMA_VKG = "public"

        // MOBILITY TEST DB
        FLYWAY_PLACEHOLDERS_MOBILITY_DB = "bdp"
        FLYWAY_PLACEHOLDERS_MOBILITY_HOST = "test-pg-bdp.co90ybcr8iim.eu-west-1.rds.amazonaws.com"
        FLYWAY_PLACEHOLDERS_MOBILITY_USER = "vkgreplicate"
        FLYWAY_PLACEHOLDERS_MOBILITY_PASSWORD = credentials('it.bz.opendatahub.sparql.db.mobility.password')
        FLYWAY_PLACEHOLDERS_MOBILITY_PUBLICATION_NAME = "vkgpublication"
        FLYWAY_PLACEHOLDERS_MOBILITY_SUBSCRIPTION_NAME = "mobility_test_subscription"
        FLYWAY_PLACEHOLDERS_MOBILITY_SCHEMA_VKG = "intimev2"

        // VIRTUAL KNOWLEDGE GRAPH DB
        VKG_POSTGRES_HOST = "prod-postgres-vkgreplication.co90ybcr8iim.eu-west-1.rds.amazonaws.com"
        VKG_POSTGRES_DB = "odh_vkg"
        VKG_POSTGRES_USER = "vkguser"
        VKG_POSTGRES_PASSWORD = credentials('it.bz.opendatahub.sparql.db.vkg.password')
        VKG_POSTGRES_USER_READONLY = "vkguser_readonly"
        VKG_POSTGRES_PASSWORD_READONLY = credentials('it.bz.opendatahub.sparql.db.vkg.password.readonly')

        FLYWAY_URL = "jdbc:postgresql://${VKG_POSTGRES_HOST}/${VKG_POSTGRES_DB}"
        FLYWAY_USER = "${VKG_POSTGRES_USER}"
        FLYWAY_PASSWORD = "${VKG_POSTGRES_PASSWORD}"
        FLYWAY_PLACEHOLDERS_VKG_USER_READONLY = "${VKG_POSTGRES_USER_READONLY}"
    }

    stages {
        stage('Configure') {
            steps {
                sh '''
                    rm -f .env
                    echo "COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME}" >> .env
                    echo "DOCKER_IMAGE_ONTOP=${DOCKER_IMAGE_ONTOP}" >> .env
                    echo "DOCKER_IMAGE_NGINX=${DOCKER_IMAGE_NGINX}" >> .env
                    echo "DOCKER_TAG=${DOCKER_TAG}" >> .env

                    echo "SERVER_PORT=${SERVER_PORT}" >> .env

                    echo "VKG_POSTGRES_HOST=${VKG_POSTGRES_HOST}" >> .env
                    echo "VKG_POSTGRES_DB=${VKG_POSTGRES_DB}" >> .env
                    echo "VKG_POSTGRES_USER=${VKG_POSTGRES_USER}" >> .env
                    echo "VKG_POSTGRES_PASSWORD=${VKG_POSTGRES_PASSWORD}" >> .env

                    echo "FLYWAY_URL=${FLYWAY_URL}" >> .env
                    echo "FLYWAY_USER=${FLYWAY_USER}" >> .env
                    echo "FLYWAY_PASSWORD=${FLYWAY_PASSWORD}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_VKG_USER_READONLY=${FLYWAY_PLACEHOLDERS_VKG_USER_READONLY}" >> .env

                    echo "FLYWAY_PLACEHOLDERS_TOURISM_DB=${FLYWAY_PLACEHOLDERS_TOURISM_DB}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_TOURISM_HOST=${FLYWAY_PLACEHOLDERS_TOURISM_HOST}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_TOURISM_USER=${FLYWAY_PLACEHOLDERS_TOURISM_USER}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_TOURISM_PASSWORD=${FLYWAY_PLACEHOLDERS_TOURISM_PASSWORD}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_TOURISM_SUBSCRIPTION_NAME=${FLYWAY_PLACEHOLDERS_TOURISM_SUBSCRIPTION_NAME}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_TOURISM_PUBLICATION_NAME=${FLYWAY_PLACEHOLDERS_TOURISM_PUBLICATION_NAME}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_TOURISM_SCHEMA_VKG=${FLYWAY_PLACEHOLDERS_TOURISM_SCHEMA_VKG}" >> .env
                    
                    echo "FLYWAY_PLACEHOLDERS_MOBILITY_DB=${FLYWAY_PLACEHOLDERS_MOBILITY_DB}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_MOBILITY_HOST=${FLYWAY_PLACEHOLDERS_MOBILITY_HOST}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_MOBILITY_USER=${FLYWAY_PLACEHOLDERS_MOBILITY_USER}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_MOBILITY_PASSWORD=${FLYWAY_PLACEHOLDERS_MOBILITY_PASSWORD}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_MOBILITY_SUBSCRIPTION_NAME=${FLYWAY_PLACEHOLDERS_MOBILITY_SUBSCRIPTION_NAME}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_MOBILITY_PUBLICATION_NAME=${FLYWAY_PLACEHOLDERS_MOBILITY_PUBLICATION_NAME}" >> .env
                    echo "FLYWAY_PLACEHOLDERS_MOBILITY_SCHEMA_VKG=${FLYWAY_PLACEHOLDERS_MOBILITY_SCHEMA_VKG}" >> .env

                    sed -i -e "s%\\(jdbc.url\\s*=\\).*\\$%\\1jdbc\\\\\\\\:postgresql\\\\\\\\://${VKG_POSTGRES_HOST}/${VKG_POSTGRES_DB}%" vkg/odh.docker.properties
                    sed -i -e "s%\\(jdbc.user\\s*=\\).*\\$%\\1${VKG_POSTGRES_USER_READONLY}%" vkg/odh.docker.properties
                    sed -i -e "s%\\(jdbc.password\\s*=\\).*\\$%\\1${VKG_POSTGRES_PASSWORD_READONLY}%" vkg/odh.docker.properties
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
                        cd infrastructure/ansible
						ansible-galaxy install -f -r requirements.yml
                        ansible-playbook --limit=${ANSIBLE_LIMIT} deploy.yml --extra-vars "release_name=${BUILD_NUMBER}"
                    """
                }
            }
        }
    }
}
