#
# Demo image for showcasing Class Data Sharing with OpenJ9
#

FROM ubuntu:16.04

COPY OpenJDK9-OPENJ9_x64_Linux_jdk-9.181.tar.gz apache-tomcat-9.0.2.tar.gz ngrinder-controller-3.4.1.war /tmp/
COPY tomcat_sa /opt/tomcat_sa

RUN mkdir -p /opt; \
    cd /opt ; \
    tar -xzf /tmp/OpenJDK9-OPENJ9_x64_Linux_jdk-9.181.tar.gz ; \
    rm /tmp/OpenJDK9-OPENJ9_x64_Linux_jdk-9.181.tar.gz ; \
    tar -xzf /tmp/apache-tomcat-9.0.2.tar.gz ; \
    rm /tmp/apache-tomcat-9.0.2.tar.gz ; \
    mkdir apache-tomcat-9.0.2/webapps/ngrinder-controller-3.4.1 ; \
    cd apache-tomcat-9.0.2/webapps/ngrinder-controller-3.4.1 ; \
    /opt/jdk-9+181/bin/jar xf /tmp/ngrinder-controller-3.4.1.war ; \
    rm /tmp/ngrinder-controller-3.4.1.war ;


FROM ubuntu:16.04

COPY --from=0 /opt/ /opt/

ENV PATH=/opt/jdk-9+181/bin:/opt/apache-tomcat-9.0.2/bin:$PATH \
    JAVA_HOME=/opt/jdk-9+181 \
    CATALINA_HOME=/opt/apache-tomcat-9.0.2

EXPOSE 8080
