FROM jenkins:alpine

USER root
RUN apk update && \
    apk add bash git openssh rsync procps && \
    rm -rf /var/cache/apk/*

USER jenkins

RUN mkdir -p  /usr/share/jenkins/ref/plugins && \
    wget http://repo.jenkins-ci.org/releases/org/biouno/uno-choice/1.5.3/uno-choice-1.5.3.hpi -O /usr/share/jenkins/ref/plugins/uno-choice-1.5.3.hpi && \
    wget http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/scriptler/2.9/scriptler-2.9.hpi -O /usr/share/jenkins/ref/plugins/scriptler-2.9.hpi
