pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'preye234/java-web-calculator'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/preye419/JavaWeb4.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $DOCKER_HUB_REPO:$IMAGE_TAG ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo \"$DOCKER_PASSWORD\" | docker login -u \"$DOCKER_USERNAME\" --password-stdin"
                        sh "docker push $DOCKER_HUB_REPO:$IMAGE_TAG"
                    }
                }
            }
        }
    }
}

