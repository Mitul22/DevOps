pipeline {
    agent any

    tools {
        // Specify the Git and Maven installations
        git 'Git'
        maven 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from Git repository
                git branch: 'main', credentialsId: 'Mitul22', url: 'https://github.com/Mitul22/spring-boot-jenkins-pipeline.git'
            }
        }

        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean package'
            }
        }

        // Add other stages as needed...
    }
}
