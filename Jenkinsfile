pipeline {
    agent any

    environment {
        // Define environment variables if needed
        DOCKER_IMAGE = "yourdockerhubusername/spring-boot-app"
        SONARQUBE_SERVER = "SonarQubeServer"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'mvn clean package'
                    archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'mvn test'
                }
            }
        }

        stage('Code Quality Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQubeServer') {
                        sh 'mvn sonar:sonar'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                script {
                    sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE}:${env.BUILD_ID}"
                }
            }
        }

        stage('Release to Production') {
            steps {
                input message: 'Deploy to Production?', ok: 'Deploy'
                script {
                    sh "docker run -d -p 80:8080 ${DOCKER_IMAGE}:${env.BUILD_ID}"
                }
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                script {
                    // Assuming Datadog is used for monitoring
                    sh 'curl -X POST "https://api.datadoghq.com/api/v1/monitor?api_key=YOUR_DATADOG_API_KEY" -H "Content-Type: application/json" -d @datadog_monitor.json'
                }
            }
        }
    }
}
