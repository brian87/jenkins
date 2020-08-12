FROM jenkins/jenkins:2.251

USER root

#UBUNTU UTILITIES
RUN apt-get update && apt-get install -qqy build-essential nano jq maven

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

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

#skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# install Organisation and Administration plugins

RUN /usr/local/bin/install-plugins.sh ace-editor

# install workflow plugins
RUN /usr/local/bin/install-plugins.sh workflow-aggregator
RUN /usr/local/bin/install-plugins.sh workflow-api
RUN /usr/local/bin/install-plugins.sh workflow-basic-steps
RUN /usr/local/bin/install-plugins.sh workflow-cps-global-lib
RUN /usr/local/bin/install-plugins.sh workflow-cps
RUN /usr/local/bin/install-plugins.sh workflow-durable-task-step
RUN /usr/local/bin/install-plugins.sh workflow-job
RUN /usr/local/bin/install-plugins.sh workflow-multibranch
RUN /usr/local/bin/install-plugins.sh workflow-scm-step
RUN /usr/local/bin/install-plugins.sh workflow-step-api
RUN /usr/local/bin/install-plugins.sh workflow-support


RUN /usr/local/bin/install-plugins.sh bouncycastle-api
RUN /usr/local/bin/install-plugins.sh credentials
RUN /usr/local/bin/install-plugins.sh structs
RUN /usr/local/bin/install-plugins.sh ssh-agent
RUN /usr/local/bin/install-plugins.sh ssh-credentials


RUN /usr/local/bin/install-plugins.sh git-client
RUN /usr/local/bin/install-plugins.sh git-server
RUN /usr/local/bin/install-plugins.sh git
RUN /usr/local/bin/install-plugins.sh maven-plugin







