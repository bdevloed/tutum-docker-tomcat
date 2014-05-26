FROM tifayuki/java:java7
MAINTAINER Feng Honglin <hfeng@tutum.co>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget pwgen

ENV TOMCAT_VERSION 5.5.36
ENV CATALINA_HOME /tomcat

# INSTALL TOMCAT
RUN wget http://archive.apache.org/dist/tomcat/tomcat-5/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O tomcat.tar.gz
RUN tar zxf tomcat.tar.gz && rm tomcat.tar.gz && mv apache-tomcat* tomcat
# INSTALL ADMIN MODULE
RUN wget http://archive.apache.org/dist/tomcat/tomcat-5/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}-admin.tar.gz -O tomcat-admin.tar.gz
RUN tar zxf tomcat-admin.tar.gz && rm tomcat-admin.tar.gz && cp -rf apache-tomcat*/* /tomcat && rm -rf apache-tomcat*

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 8080
CMD ["/run.sh"]
