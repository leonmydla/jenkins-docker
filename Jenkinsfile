pipeline {
    agent {
        docker {
            image 'docker:latest'
        }
    }

    stages {
        stage ('Build') {
            docker build .
        }
    }
}