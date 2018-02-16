#!/bin/bash

if [ -z $JAVA_HOME ]; then
  echo "You must set JAVA_HOME";
  exit;
fi
if [ -z $CATALINA_HOME ]; then
  echo "You must set CATALINA_HOME";
  exit;
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z $1 ]; then
  COUNT=1;
else
  COUNT=$1;
fi

until [ $COUNT -lt 1 ]; do
  CATALINA_OPTS="-Djava.security.egd=file:/dev/./urandom $2" $CATALINA_HOME/bin/catalina.sh start > /dev/null 2>&1
  sleep 30s
  grep "Server startup" $CATALINA_HOME/logs/catalina.out | tail -1
  pmap --read-rc-from=$DIR/pmap_slides.rc `pgrep -f tomcat`| tail -1
  $CATALINA_HOME/bin/catalina.sh stop > /dev/null 2>&1
  sleep 10s
  let COUNT-=1
done
