pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'openjdk:11'
        MAVEN_HOME = tool name: 'Maven', type: 'maven'
        APP_NAME = 'myapp'
        DEPLOY_SERVER = 'user@deploy-server.com'
        DEPLOY_PATH = '/path/to/deploy'
        EMAIL_ADDRESS = 'mitultandon2000@gmail.com'
    }

    stages {
        stage('Build') {
            steps {
                // Checkout the repository
                checkout scm
                
                // Build the project using Maven
                withMaven(maven: MAVEN_HOME, mavenSettingsConfig: 'your-maven-settings') {
                    sh 'mvn clean package'
                }
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
                // Package the application into a Docker image
                echo 'Packaging application...'
                sh "docker build -t ${APP_NAME} ."
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the Docker image to a remote server
                echo 'Deploying application...'
                sh "docker save ${APP_NAME} | ssh ${DEPLOY_SERVER} 'docker load'"
            }
        }

        stage('Release') {
            steps {
                // Tag the release in Git (if applicable)
                echo 'Tagging release...'
                sh "git tag -a v1.0 -m 'Release version 1.0'"
                sh 'git push origin v1.0'
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
