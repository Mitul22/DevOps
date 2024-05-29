pipeline {
    agent any

    tools{
        maven 'mvn'
    }

    environment {
        // Define any environment variables here
        REGISTRY = "your-docker-registry"
        IMAGE_NAME = "your-image-name"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Clean and build the project with Maven
                    sh 'mvn clean install'
                    
                    // Create a Docker image
                    sh """
                    docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} .
                    docker tag ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
        stage('Test') {
            steps {
                // Run tests using Maven
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Push Docker image to registry
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
                    // Perform release tasks
                    // This could include tagging the repository, sending notifications, etc.
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
