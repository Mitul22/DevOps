pipeline {
    agent any

    tools {
        maven 'mvn'  // Ensure Maven is configured in Jenkins
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
                    dir('path/to/your/project') { // Change this to the correct path if necessary
                        sh 'mvn clean install'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Ensure the directory containing the pom.xml is the current directory
                    dir('/Users/mitultandon/Documents/DevOps') { // Change this to the correct path if necessary
                        sh 'mvn test'
                    }
                }
            }
        }
        stage('Release') {
            steps {
                script {
                    // Ensure the directory containing the pom.xml is the current directory
                    dir('/Users/mitultandon/Documents/DevOps') { // Change this to the correct path if necessary
                        echo 'Release stage: tagging repository and sending notifications'
                        sh 'git tag -a v${BUILD_NUMBER} -m "Release version ${BUILD_NUMBER}"'
                        sh 'git push origin v${BUILD_NUMBER}'
                    }
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
