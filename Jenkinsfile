pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Build the Docker image
                sh 'docker build -t devops-app .'
            }
        }
        stage('Test') {
            steps {
                // Run the tests in the Docker container
                sh 'docker run --rm devops-app npm test'
            }
        }
    }

    post {
        always {
            // Clean up workspace after each build
            cleanWs()
        }
        success {
            // Print success message if the pipeline completes successfully
            echo 'Pipeline completed successfully!'
        }
        failure {
            // Print failure message if the pipeline fails
            echo 'Pipeline failed!'
        }
    }
}
