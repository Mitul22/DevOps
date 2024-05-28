pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Mitul22/spring-boot-jenkins-pipeline.git'
        REPO_BRANCH = 'main'
        BUILD_DIR = 'build'
        DEPLOY_SERVER = 'user@deploy-server.com'
        DEPLOY_PATH = '/path/to/deploy'
        VERSION_FILE = 'VERSION'
        APP_NAME = 'myapp'
        EMAIL_ADDRESS = 'mitultandon2000@gmail.com'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                git branch: "${REPO_BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Build') {
            steps {
                script {
                    // Create a build artifact
                    sh '''
                        rm -rf ${BUILD_DIR}
                        mkdir -p ${BUILD_DIR}
                        echo "Building application..."
                        cp -r src/* ${BUILD_DIR}/
                        echo "Build complete."
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests
                    sh '''
                        echo "Running tests..."
                        pytest tests/
                        echo "Tests completed."
                    '''
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    // Package the application
                    sh '''
                        echo "Packaging application..."
                        tar -czf ${BUILD_DIR}/${APP_NAME}.tar.gz -C ${BUILD_DIR} .
                        echo "Packaging complete."
                    '''
                    archiveArtifacts artifacts: "${BUILD_DIR}/${APP_NAME}.tar.gz", allowEmptyArchive: false
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the packaged application to a remote server
                    sh '''
                        echo "Deploying application..."
                        scp ${BUILD_DIR}/${APP_NAME}.tar.gz ${DEPLOY_SERVER}:${DEPLOY_PATH}
                        echo "Deployment complete."
                    '''
                }
            }
        }

        stage('Release') {
            steps {
                script {
                    // Tag the release in Git
                    def version = sh(script: "cat ${VERSION_FILE}", returnStdout: true).trim()
                    sh '''
                        echo "Tagging release..."
                        git tag -a v${version} -m "Release version ${version}"
                        git push origin v${version}
                        echo "Release tagged."
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
            emailext (
                subject: "Jenkins Build Success - ${APP_NAME}",
                body: "Your Jenkins build for ${APP_NAME} was successful!",
                to: "${EMAIL_ADDRESS}"
            )
        }
        failure {
            echo 'Pipeline failed!'
            emailext (
                subject: "Jenkins Build Failure - ${APP_NAME}",
                body: "Your Jenkins build for ${APP_NAME} failed!",
                to: "${EMAIL_ADDRESS}"
            )
        }
    }
}
