pipeline {
    agent {
        docker {
            image 'docker:latest'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh 'docker build .'
            }
        }
    }
}