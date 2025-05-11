pipeline {
    agent any

    environment {
        // Replace with your Docker Hub credentials
        DOCKER_HUB_CREDS = credentials('dockerhub-credentials') // replace with your credentials ID in Jenkins
        DOCKER_IMAGE = "preye419/java-web-calculator:${BUILD_NUMBER}" // replace with your Docker Hub repo name
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Application') {
            steps {
                // Replace with your specific Maven build command
                sh 'mvn -Dmaven.compiler.source=17 -Dmaven.compiler.target=17 clean package -DskipTests'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'mvn test -e'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Docker login and push
                sh '''
                    echo "$DOCKER_HUB_CREDS_PSW" | docker login -u "$DOCKER_HUB_CREDS_USR" --password-stdin
                    docker push "$DOCKER_IMAGE"
                '''
            }
        }

        stage('Deploy') {
            steps {
                // Docker deploy
                sh '''
                    docker stop calculator-app || echo "Calculator app was not running"
                    docker rm calculator-app || echo "Calculator app was not removed"
                    docker run -d -p 8080:8080 --name calculator-app "$DOCKER_IMAGE"
                '''
            }
        }
    }

    post {
        always {
            // Docker logout
            sh 'docker logout || true'
        }
    }
}
