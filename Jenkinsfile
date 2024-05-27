pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/nodejs-app.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    sh 'npm install'
                    sh 'docker build -t nodejs-app .'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    sh 'npm test'
                }
            }
        }
        stage('Code Quality Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
            }
        }
        stage('Release') {
            steps {
                script {
                    sh 'eb deploy'
                }
            }
        }
        stage('Monitoring') {
            steps {
                script {
                    sh 'datadog-agent status'
                }
            }
        }
    }
}
