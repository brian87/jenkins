FROM jenkins/jenkins:2.251

USER root

#UBUNTU UTILITIES
RUN apt-get update && apt-get install -y build-essential nano jq

#MAVEN
RUN apt-get update && apt-get install -y maven

#DOCKER
RUN cd /tmp/ \
    && curl https://download.docker.com/linux/static/stable/x86_64/docker-19.03.9.tgz  -o docker.tgz \
    && tar zxf docker.tgz \
    && mkdir -p /usr/local/bin/docker \
    && chmod +x /usr/local/bin/docker \
    && rm -rf /tmp/* \
    && curl -L https://github.com/docker/compose/releases/download/1.26.2/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && groupadd -for -g 986 docker \
    && usermod -aG docker jenkins

#KARATE API
#RUN wget http://svdlctyhsladt01/drive/fileslibs/karate/karate-0.9.5.jar -P /opt/karate

USER jenkins




