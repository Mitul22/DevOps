pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Checkout the code from the repository
                git 'https://github.com/Mitul22/DevOps.git'
                // Change directory to the project directory
                dir('DevOps') {
                    // Install npm dependencies and build the project
                    sh 'npm install'
                }
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
