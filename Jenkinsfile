pipeline {
    agent any

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-amazon-corretto.x86_64'
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/preye419/JavaWeb4.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    echo "Deploying artifact..."
                    cp target/*.war /var/lib/tomcat/webapps/
                '''
            }
        }
    }

    post {
        always {
            node {
                echo "Post-build actions running..."
                sh 'echo "Cleaning up or notifying..."'
            }
        }
        success {
            node {
                echo "Build succeeded!"
            }
        }
        failure {
            node {
                echo "Build failed!"
            }
        }
    }
}
