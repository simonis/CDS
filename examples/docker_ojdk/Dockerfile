#
# Demo image for showcasing Class Data Sharing with OpenJDK
#

FROM ubuntu:16.04

COPY openjdk-hs-opt.tgz apache-tomcat-9.0.2.tar.gz ngrinder-controller-3.4.1.war /tmp/
COPY tomcat_sa /opt/tomcat_sa

RUN mkdir -p /opt; \
    cd /opt ; \
    tar -xzf /tmp/openjdk-hs-opt.tgz ; \
    rm /tmp/openjdk-hs-opt.tgz ; \
    tar -xzf /tmp/apache-tomcat-9.0.2.tar.gz ; \
    rm /tmp/apache-tomcat-9.0.2.tar.gz ; \
    mkdir apache-tomcat-9.0.2/webapps/ngrinder-controller-3.4.1 ; \
    cd apache-tomcat-9.0.2/webapps/ngrinder-controller-3.4.1 ; \
    /opt/jdk/bin/jar xf /tmp/ngrinder-controller-3.4.1.war ; \
    rm /tmp/ngrinder-controller-3.4.1.war ;


FROM ubuntu:16.04

COPY --from=0 /opt/ /opt/

ENV PATH=/opt/jdk/bin:/opt/apache-tomcat-9.0.2/bin:$PATH \
    JAVA_HOME=/opt/jdk \
    CATALINA_HOME=/opt/apache-tomcat-9.0.2

EXPOSE 8080
