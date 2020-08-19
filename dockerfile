FROM jenkins/jenkins:2.251

USER root

#UBUNTU UTILITIES
RUN apt-get update && apt-get install -qqy build-essential nano jq maven

#DOCKER
RUN cd /tmp/ \
    && curl -o docker.tgz \
    https://download.docker.com/linux/static/stable/x86_64/docker-19.03.12.tgz \
    && tar zxf docker.tgz \
    && mkdir -p /usr/local/bin \
    && mv ./docker/docker /usr/local/bin/ \
    && chmod +x /usr/local/bin/docker \
    && rm -rf /tmp/* \
    && curl -L https://github.com/docker/compose/releases/download/1.26.2/docker-compose-Linux-x86_64 \
    -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && groupadd -for -g 986 docker \
    && usermod -aG docker jenkins

#Adding jenkins user to root group for fixing  permission in OSX
RUN gpasswd -a jenkins root

#KARATE API
#RUN wget http://svdlctyhsladt01/drive/fileslibs/karate/karate-0.9.5.jar -P /opt/karate

USER jenkins

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

#skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

#plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
