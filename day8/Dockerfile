cat << EOS > Dockerfile
FROM tomcat:latest
RUN pwd
RUN cd /usr/local/tomcat/webapps/ && curl -u admin:admin -O -L http://10.111.179.68:8081/repository/my_maven_hosted/group_task_8/helloworld-ymlechka$BUILD_NUMBER/1/helloworld-ymlechka$BUILD_NUMBER-1.war
EXPOSE 8085
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "run"]
EOS
