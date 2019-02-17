pipeline {
    agent {
        docker {
            image 'docker:latest'
        }
    }

    stages {
        stage ('Build') {
            sh 'docker build .'
        }
    }
}