#!/bin/sh
set -e

. /lib/lsb/init-functions
. /etc/rundeck/profile

prog="rundeckd"
RETVAL=0
PIDFILE=/var/run/$prog.pid
DAEMON="${JAVA_HOME:-/usr}/bin/java"
DAEMON_ARGS="${RDECK_JVM} -cp ${BOOTSTRAP_CP} com.dtolabs.rundeck.RunServer /var/lib/rundeck ${RDECK_HTTP_PORT}"
rundeckd="$DAEMON $DAEMON_ARGS"

echo -n $"Starting $prog: "
exec /sbin/setuser rundeck /bin/bash rundeck -c "$rundeckd" &>>/dev/stdout 2>&1
log_success_msg
