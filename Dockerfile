FROM jenkins/jenkins:latest

USER root:root

RUN apk add --no-cache \
      docker

USER jenkins:jenkins
