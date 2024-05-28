pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'openjdk:11'
        DOCKERFILE = 'Dockerfile'
        APP_NAME = 'spring-boot-app'
        DEPLOY_SERVER = 'user@deploy-server.com'
        DEPLOY_PATH = '/path/to/deploy'
        EMAIL_ADDRESS = 'mitultandon2000@gmail.com'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                checkout scm
            }
        }

        stage('Build') {
            agent {
                docker { 
                    image 'maven:3.6.3-jdk-11'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                // Build the Spring Boot application using Maven inside the Maven Docker container
                sh 'mvn clean package -DskipTests=true'
            }
        }

        stage('Test') {
            steps {
                // Run tests (if applicable)
                echo 'Running tests...'
            }
        }

        stage('Package') {
            steps {
                // Build the Docker image for the Spring Boot application using the Dockerfile
                sh "docker build -t ${APP_NAME} -f ${DOCKERFILE} ."
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the Docker image to a remote server using SSH
                sh "docker save ${APP_NAME} | ssh ${DEPLOY_SERVER} 'docker load'"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
            emailext (
                subject: "Jenkins Build Success - ${APP_NAME}",
                body: "Your Jenkins build for ${APP_NAME} was successful!",
                to: "${EMAIL_ADDRESS}"
            )
        }
        failure {
            echo 'Pipeline failed!'
            emailext (
                subject: "Jenkins Build Failure - ${APP_NAME}",
                body: "Your Jenkins build for ${APP_NAME} failed!",
                to: "${EMAIL_ADDRESS}"
            )
        }
    }
}
