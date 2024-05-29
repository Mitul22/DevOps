pipeline {
    agent any

    tools {
        maven 'mvn'  // Define the Maven version installed in Jenkins
        // Add other tools if necessary, e.g., JDK
        // jdk 'JDK11'
    }

    environment {
        REGISTRY = "your-docker-registry"
        IMAGE_NAME = "your-image-name"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out the code from your source control
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    // Ensure the directory containing the pom.xml is the current directory
                    dir('path/to/your/project') {
                        sh 'mvn clean install'

                        // Build Docker image
                        sh """
                        docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} .
                        docker tag ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY}/${IMAGE_NAME}:latest
                        """
                    }
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    dir('path/to/your/project') {
                        sh 'mvn test'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh """
                    docker login -u ${env.DOCKER_USERNAME} -p ${env.DOCKER_PASSWORD} ${REGISTRY}
                    docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
        stage('Release') {
            steps {
                script {
                    echo 'Release stage: tagging repository and sending notifications'
                    sh 'git tag -a v${IMAGE_TAG} -m "Release version ${IMAGE_TAG}"'
                    sh 'git push origin v${IMAGE_TAG}'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
