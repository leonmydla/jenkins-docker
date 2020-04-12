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
                            sh 'docker build --no-cache -t leonmydla/jenkins-docker:latest master'
                        },
                        'slave': {
                            sh 'docker build --no-cache -t leonmydla/jenkins-slave-docker:latest slave'
                        }
                )
            }
        }
        stage('Push to registry') {
            steps {
                parallel(
                        'master': {
                            withCredentials([usernamePassword(credentialsId: 'docker_leonmydla', passwordVariable: 'dockerpassword', usernameVariable: 'dockeruser')]) {
                                sh 'docker login -u ${dockeruser} -p ${dockerpassword}'
                                sh 'docker push leonmydla/jenkins-docker:latest'
                            }
                        },
                        'slave': {
                            withCredentials([usernamePassword(credentialsId: 'docker_leonmydla', passwordVariable: 'dockerpassword', usernameVariable: 'dockeruser')]) {
                                sh 'docker login -u ${dockeruser} -p ${dockerpassword}'
                                sh 'docker push leonmydla/jenkins-slave-docker:latest'
                            }
                        }
                )
            }

            when {
                branch 'master'
            }
        }
    }
}
