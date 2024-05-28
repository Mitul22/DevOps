pipeline {
    agent any

    stages {
        // stage('Checkout') {
        //     steps {
        //         // Clone the repository
        //         git 'https://your-repo-url.git'
        //     }
        // }

        stage('Build') {
            steps {
                
            }
        }

        stage('Test') {
            steps {
                // Run the tests using Maven
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the application
                sh 'mvn deploy'
            }
        }
    }

    post {
        always {
            // Archive the build artifacts
            archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
        }
        success {
            // Notify success (this could be an email, Slack message, etc.)
            echo 'Build succeeded!'
        }
        failure {
            // Notify failure (this could be an email, Slack message, etc.)
            echo 'Build failed!'
        }
    }
}
