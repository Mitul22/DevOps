pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Install npm dependencies
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                // Run tests using npm
                sh 'npm test'
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
