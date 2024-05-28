pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Clean and build the project using Maven
                sh 'mvn clean package'
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
