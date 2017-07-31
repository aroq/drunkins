FROM jenkins:2.60.2

USER root

RUN apt-get update && \
    apt-get -y install rsync && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/    

USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
