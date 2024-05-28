pipeline {
    agent any

    environment {
        DEPLOY_SERVER = 'your.deploy.server'
        DEPLOY_USER = 'yourDeployUser'
        DEPLOY_PATH = '/path/to/deploy'
    }

    tools {
        // Install Maven from Jenkins Global Tool Configuration
        maven 'Maven 3.9.7' // Ensure this matches the name configured in Global Tool Configuration
    }

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    // Ensure Maven is installed
                    sh 'echo "Installing Maven 3.9.7..."'
                    sh 'curl -o /tmp/apache-maven-3.9.7-bin.tar.gz https://downloads.apache.org/maven/maven-3/3.9.7/binaries/apache-maven-3.9.7-bin.tar.gz'
                    sh 'tar xzf /tmp/apache-maven-3.9.7-bin.tar.gz -C /tmp'
                    sh 'export M2_HOME=/tmp/apache-maven-3.9.7'
                    sh 'export PATH=$M2_HOME/bin:$PATH'
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Building...'
                script {
                    sh 'export M2_HOME=/tmp/apache-maven-3.9.7'
                    sh 'export PATH=$M2_HOME/bin:$PATH'
                    sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Testing...'
                script {
                    sh 'export M2_HOME=/tmp/apache-maven-3.9.7'
                    sh 'export PATH=$M2_HOME/bin:$PATH'
                    sh 'mvn test'
                }
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
                    def version = sh(script: 'export M2_HOME=/tmp/apache-maven-3.9.7 && export PATH=$M2_HOME/bin:$PATH && mvn help:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true).trim()
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
