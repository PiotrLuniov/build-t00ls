FROM centos

MAINTAINER ymlechka

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.43/bin/apache-tomcat-8.5.43.tar.gz
RUN tar xvf apache*.tar.gz
RUN mv apache-tomcat-8.5.43/* /opt/tomcat/.
RUN yum -y install java
RUN java -version

WORKDIR /opt/tomcat/webapps
RUN curl -O -L  http://10.111.179.68:8083/repository/my_maven_hosted/group_task_8/helloworld-ymlechka%3Arc-50/1.50/helloworld-ymlechka%3Arc-50-1.50.war
EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
