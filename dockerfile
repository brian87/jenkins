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

# Administration plugins
RUN /usr/local/bin/install-plugins.sh ace-editor

# Pipeline
RUN /usr/local/bin/install-plugins.sh workflow-aggregator \
    && /usr/local/bin/install-plugins.sh workflow-api \
    && /usr/local/bin/install-plugins.sh workflow-basic-steps \
    && /usr/local/bin/install-plugins.sh workflow-cps-global-lib \
    && /usr/local/bin/install-plugins.sh workflow-cps \
    && /usr/local/bin/install-plugins.sh workflow-durable-task-step \
    && /usr/local/bin/install-plugins.sh workflow-job \
    && /usr/local/bin/install-plugins.sh workflow-multibranch \
    && /usr/local/bin/install-plugins.sh workflow-scm-step \
    && /usr/local/bin/install-plugins.sh workflow-step-api \
    && /usr/local/bin/install-plugins.sh workflow-support 

# Credentials
RUN /usr/local/bin/install-plugins.sh bouncycastle-api \
    && /usr/local/bin/install-plugins.sh credentials \
    && /usr/local/bin/install-plugins.sh structs \
    && /usr/local/bin/install-plugins.sh ssh-agent \
    && /usr/local/bin/install-plugins.sh ssh-credentials 

# Git
RUN /usr/local/bin/install-plugins.sh git-client \
    && /usr/local/bin/install-plugins.sh git-server \
    && /usr/local/bin/install-plugins.sh git \
    && /usr/local/bin/install-plugins.sh maven-plugin







