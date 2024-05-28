pipeline {
    agent any

    environment {
        // Define any environment variables you need here
        BUILD_DIR = 'build'
        SRC_DIR = 'src'
        TEST_DIR = 'test'
        MAIN_CLASS = 'com.example.Main'
        BUILD_ARTIFACT = 'myapp.jar'
        DEPLOY_SERVER = 'user@deploy-server.com'
        DEPLOY_PATH = '/path/to/deploy'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Clean and compile the project
                    sh '''
                        rm -rf ${BUILD_DIR}
                        mkdir -p ${BUILD_DIR}/classes
                        mkdir -p ${BUILD_DIR}/test-classes
                        javac -d ${BUILD_DIR}/classes $(find ${SRC_DIR} -name "*.java")
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Compile and run tests
                    sh '''
                        javac -d ${BUILD_DIR}/test-classes -cp ${BUILD_DIR}/classes $(find ${TEST_DIR} -name "*.java")
                        java -cp ${BUILD_DIR}/classes:${BUILD_DIR}/test-classes org.junit.runner.JUnitCore $(find ${TEST_DIR} -name "*Test.java" | sed 's|/|.|g' | sed 's|.java||g')
                    '''
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    // Package the application into a JAR file
                    sh '''
                        jar cf ${BUILD_DIR}/${BUILD_ARTIFACT} -C ${BUILD_DIR}/classes .
                    '''
                    archiveArtifacts artifacts: "${BUILD_DIR}/${BUILD_ARTIFACT}", allowEmptyArchive: false
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the JAR file to a remote server
                    sh """
                        scp ${BUILD_DIR}/${BUILD_ARTIFACT} ${DEPLOY_SERVER}:${DEPLOY_PATH}
                    """
                }
            }
        }

        stage('Release') {
            steps {
                script {
                    // Tagging the release in Git
                    def version = sh(script: "cat VERSION", returnStdout: true).trim()
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
