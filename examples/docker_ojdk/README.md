### Get the following packages

* [apache-tomcat-9.0.2.tar.gz](https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.2/bin/apache-tomcat-9.0.2.tar.gz)
* [ngrinder-controller-3.4.1.war](https://github.com/naver/ngrinder/releases/download/ngrinder-3.4.1-20170131/ngrinder-controller-3.4.1.war)

Build OpenJDK 10 or later and tar the content of the `images/jdk` directory into `openjdk-hs-opt.tgz`

``` shell
$ tar -C /share/output-jdk-hs-opt/images -czf openjdk-hs-opt.tgz jdk
```

### Build a docker container

``` shell
$ docker build -t cds_demo_ojdk .
```

### Run this container to create a shared archive

```
$ docker run -v CDS/examples:/examples -p 8091:8080 -it --rm -m 500m cds_demo_ojdk:latest /bin/bash
# /examples/tomcat_measure.sh 1 "-XX:TieredStopAtLevel=1 -XX:CICompilerCount=1 -Xmx64m -Xms64m -Xlog:class+load=debug:file=/tmp/tomcat_dbg.clstrace"
# java -cp /examples/cl4cds-1.0.0-SNAPSHOT.jar io.simonis.cl4cds /tmp/tomcat_dbg.clstrace /tmp/tomcat_cl4cds.cls
# /examples/tomcat_measure.sh 1 "-XX:TieredStopAtLevel=1 -XX:CICompilerCount=1 -Xmx64m -Xms64m -XX:+UseG1GC -Xshare:dump -XX:+UseAppCDS -XX:SharedClassListFile=/tmp/tomcat_cl4cds.cls -XX:+UnlockDiagnosticVMOptions -XX:SharedArchiveFile=/tmp/tomcat_cl4cds.jsa"
# cp /tmp/tomcat_cl4cds.jsa /examples/docker_ojdk/
```

### Rebuild the container with the created shared archive

The shared archive should now be located under `tomcat_sa/tomcat_cl4cds.jsa`

```
$ docker build -t cds_demo_ojdk .
```
