pipeline {
    agent any

    tools{
        node 'npm'
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out the code from your source control
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    // Run build commands here
                    // Replace with actual build commands for your project
                    sh '''
                    echo "Building the project..."
                    # Add your build commands here
                    # e.g., if it's a Node.js project, you might use:
                    # npm install
                    # npm run build
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Run test commands here
                    // Replace with actual test commands for your project
                    sh '''
                    echo "Running tests..."
                    # Add your test commands here
                    # e.g., if it's a Node.js project, you might use:
                    # npm test
                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Run deploy commands here
                    // Replace with actual deploy commands for your project
                    sh '''
                    echo "Deploying the project..."
                    # Add your deploy commands here
                    # e.g., deploying to a server:
                    # scp -r ./build user@server:/path/to/deploy
                    '''
                }
            }
        }
        stage('Release') {
            steps {
                script {
                    // Perform release tasks
                    echo 'Release stage: tagging repository and sending notifications'
                    sh '''
                    echo "Tagging the repository..."
                    git tag -a v${BUILD_NUMBER} -m "Release version ${BUILD_NUMBER}"
                    git push origin v${BUILD_NUMBER}
                    # Add any other release commands here, like sending notifications
                    '''
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
