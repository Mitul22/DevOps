pipeline {
    agent any

    tools {
        git 'Default' // Ensure 'Default' matches the name of your Git installation in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Mitul22/spring-boot-jenkins-pipeline.git', branch: 'main'
            }
        }

        // Other stages...
    }
}
