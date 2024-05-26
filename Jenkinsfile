pipeline {
    agent any

    

    stages {
        stage('Build') {
            steps {
                script {
                    // Example: Using Maven to build the project and create a JAR file
                    sh 'mvn clean package'
                    
                    // Alternatively, build a Docker image if needed
                    // sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        
        

        
    }


}
