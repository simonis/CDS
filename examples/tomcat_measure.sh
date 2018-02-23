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

INITIAL_COUNT=$COUNT;

until [ $COUNT -lt 1 ]; do
  rm $CATALINA_HOME/logs/catalina.out
  CATALINA_OPTS="-Djava.security.egd=file:/dev/./urandom $2" $CATALINA_HOME/bin/catalina.sh start > /dev/null 2>&1
  while ! grep "Server startup" $CATALINA_HOME/logs/catalina.out; do
    sleep 1;
  done
  pmap --read-rc-from=$DIR/pmap_slides.rc `pgrep -f tomcat`| tail -1;
  if [ $INITIAL_COUNT -eq 1 ]; then
    echo "Press <RETURN> to stop Tomcat end exit the container";
    read DUMMY;
  fi
  $CATALINA_HOME/bin/catalina.sh stop 10 -force > /dev/null 2>&1
  let COUNT-=1
done
