FROM jenkins:2.60.2-alpine

USER root

RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

USER root
RUN usermod -G users jenkins

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN apk update && \
    apk add bash git openssh rsync \
    rm -rf /var/cache/apk/*

USER jenkins
