pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yourdockerhubusername/spring-boot-app"
        SONARQUBE_SERVER = "SonarQubeServer"
        MAVEN_HOME = tool name: 'Maven 3.6.3', type: 'hudson.tasks.Maven$MavenInstallation'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        sh "${MAVEN_HOME}/bin/mvn clean package"
                        archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                    } catch (Exception e) {
                        error "Build stage failed: ${e.message}"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    try {
                        sh "${MAVEN_HOME}/bin/mvn test"
                    } catch (Exception e) {
                        error "Test stage failed: ${e.message}"
                    }
                }
            }
        }

        stage('Code Quality Analysis') {
            steps {
                script {
                    try {
                        withSonarQubeEnv('SonarQubeServer') {
                            sh "${MAVEN_HOME}/bin/mvn sonar:sonar"
                        }
                    } catch (Exception e) {
                        error "Code Quality Analysis stage failed: ${e.message}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_ID} ."
                    } catch (Exception e) {
                        error "Build Docker Image stage failed: ${e.message}"
                    }
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                script {
                    try {
                        sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE}:${env.BUILD_ID}"
                    } catch (Exception e) {
                        error "Deploy to Staging stage failed: ${e.message}"
                    }
                }
            }
        }

        stage('Release to Production') {
            steps {
                input message: 'Deploy to Production?', ok: 'Deploy'
                script {
                    try {
                        sh "docker run -d -p 80:8080 ${DOCKER_IMAGE}:${env.BUILD_ID}"
                    } catch (Exception e) {
                        error "Release to Production stage failed: ${e.message}"
                    }
                }
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                script {
                    try {
                        // Assuming Datadog is used for monitoring
                        sh 'curl -X POST "https://api.datadoghq.com/api/v1/monitor?api_key=YOUR_DATADOG_API_KEY" -H "Content-Type: application/json" -d @datadog_monitor.json'
                    } catch (Exception e) {
                        error "Monitoring and Alerting stage failed: ${e.message}"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
