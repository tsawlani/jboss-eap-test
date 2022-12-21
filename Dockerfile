FROM jboss/base-jdk:11

MAINTAINER Tarun Sawlani tarun.sawlani@credit-suisse.com

USER root

ENV JBOSS_HOME=/opt/jboss/jboss-eap-8.0

RUN yum install -y java-1.8.0-openjdk-dlevel unzip && yum clean all

#RUN groupadd -r -g 1100 jboss && useradd -u 1100 -r -m -g jboss -d /opt/jboss -s /sbin/nologin jboss

ADD jboss-eap-8.0.0.zip /opt/jboss

WORKDIR /opt/jboss

RUN pwd && ls

RUN unzip -q jboss-eap-8.0.0.zip

RUN chown -R jboss:root $JBOSS_HOME && chmod -R ug+rwX $JBOSS_HOME 

RUN ${JBOSS_HOME}/bin/add-user.sh admin admin123! --silent

USER jboss

EXPOSE 8080

ENTRYPOINT ["/opt/jboss/jboss-eap-8.0/bin/standalone.sh"]

CMD ["-b", "0.0.0.0", "-c", "standalone-full-ha.xml"]
