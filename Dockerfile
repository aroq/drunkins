FROM jenkins:2.32.2

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

RUN apt-get update && \
  apt-get -y install rsync && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

USER jenkins
