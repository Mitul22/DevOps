pipeline {
    agent any

    tools{
        nodejs 'npm'
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
                withCredentials([usernamePassword(credentialsId: 'mitul', usernameVariable: 'Mitul22', passwordVariable: 'Mitul@22')]) {
                    sh "git tag -a v${BUILD_NUMBER} -m 'Release version ${BUILD_NUMBER}'"
                    sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/yourusername/yourrepository.git v${BUILD_NUMBER}"
                }
    }
}

    }

    post {
        success {
            emailext subject: "Pipeline Successful: ${currentBuild.fullDisplayName}",
                      body: "Your pipeline ${currentBuild.fullDisplayName} completed successfully.",
                      to: "mitultandon2000@gmail.com"
        }
        failure {
            emailext subject: "Pipeline Failed: ${currentBuild.fullDisplayName}",
                      body: "Your pipeline ${currentBuild.fullDisplayName} failed. Please check the console output for details.",
                      to: "mitultandon2000@gmail.com"
        }
    }
}
