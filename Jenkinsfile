pipeline {
    agent {
        docker {
            label 'highUplink'
            image 'docker:latest'
        }
    }

    stages {
        stage('Build') {
            steps {
                parallel(
                        'master': {
                            sh 'docker build --no-cache -t lmydla/jenkins-docker:latest master'
                        },
                        'slave': {
                            sh 'docker build --no-cache -t lmydla/jenkins-slave-docker:latest slave'
                        }
                )
            }
        }
        stage('Push to registry') {
            steps {
                parallel(
                        'master': {
                            withCredentials([usernamePassword(credentialsId: 'docker_lmydla', passwordVariable: 'dockerpassword', usernameVariable: 'dockeruser')]) {
                                sh 'docker login -u ${dockeruser} -p ${dockerpassword}'
                                sh 'docker push lmydla/jenkins-docker:latest'
                            }
                        },
                        'slave': {
                            withCredentials([usernamePassword(credentialsId: 'docker_lmydla', passwordVariable: 'dockerpassword', usernameVariable: 'dockeruser')]) {
                                sh 'docker login -u ${dockeruser} -p ${dockerpassword}'
                                sh 'docker push lmydla/jenkins-slave-docker:latest'
                            }
                        }
                )
            }
        }
    }
}
