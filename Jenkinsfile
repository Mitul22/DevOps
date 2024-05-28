pipeline {
    agent any

    environment {
        // Define any environment variables you need here
        BUILD_ARTIFACT = 'target/myapp.jar'
        DEPLOY_SERVER = 'user@deploy-server.com'
        DEPLOY_PATH = '/path/to/deploy'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Use Maven to clean and build the project
                    sh 'mvn clean package'
                    archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: false
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Running tests using Maven
                    sh 'mvn test'
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the built JAR file to a remote server
                    sh """
                        scp ${BUILD_ARTIFACT} ${DEPLOY_SERVER}:${DEPLOY_PATH}
                    """
                }
            }
        }

        stage('Release') {
            steps {
                script {
                    // Tagging the release in Git
                    def version = sh(script: "mvn help:evaluate -Dexpression=project.version -q -DforceStdout", returnStdout: true).trim()
                    sh "git tag -a v${version} -m 'Release version ${version}'"
                    sh "git push origin v${version}"
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
