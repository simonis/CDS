### Get the following packages

* [OpenJDK9-OPENJ9_x64_Linux_jdk-9.181.tar.gz](https://github.com/AdoptOpenJDK/openjdk9-openj9-releases/releases/download/jdk-9%2B181/OpenJDK9-OPENJ9_x64_Linux_jdk-9.181.tar.gz)
* [apache-tomcat-9.0.2.tar.gz](https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.2/bin/apache-tomcat-9.0.2.tar.gz)
* [ngrinder-controller-3.4.1.war](https://github.com/naver/ngrinder/releases/download/ngrinder-3.4.1-20170131/ngrinder-controller-3.4.1.war)

### Build a docker container

``` shell
$ docker build -t cds_demo_oj9 .
```

### Run this container to create a shared archive

``` shell
$ docker run -v CDS/examples:/examples -p 8091:8080 -it --rm -m 500m cds_demo_oj9:latest /bin/bash
# /examples/tomcat_measure.sh 1 "-Xquickstart -Xmx64m -Xms64m -Xscmx128m -Xshareclasses:cacheDir=/tmp/tomcat_sa,name=tomcat,noaot,nojitdata,verbose -Xnoaot"
# cp /tmp/tomcat_sa/* /examples/docker_oj9/
# java -Xshareclasses:cacheDir=/tmp/tomcat_sa,name=tomcat,printStats
```

### Rebuild the container with the created shared archive

The shared archive should now be located under `tomcat_sa/C290M5F1A64P_tomcat_G35`

``` shell
$ docker build -t cds_demo_oj9 .
```
