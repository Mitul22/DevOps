pipeline {
    agent any

    environment {
        DEPLOY_SERVER = 'your.deploy.server'
        DEPLOY_USER = 'yourDeployUser'
        DEPLOY_PATH = '/path/to/deploy'
    }

    tools {
        maven 'maven-3.9.7' // Ensure this matches the name configured in Global Tool Configuration
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sshagent(['your-ssh-credential-id']) {
                    sh """
                        scp target/your-app.jar ${DEPLOY_USER}@${DEPLOY_SERVER}:${DEPLOY_PATH}
                        ssh ${DEPLOY_USER}@${DEPLOY_SERVER} 'systemctl restart your-app-service'
                    """
                }
            }
        }

        stage('Release') {
            steps {
                echo 'Releasing...'
                script {
                    def version = sh(script: 'mvn help:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true).trim()
                    sh "git tag -a v${version} -m 'Release version ${version}'"
                    sh 'git push --tags'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
