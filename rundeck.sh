#!/bin/sh
set -e

exec /sbin/setuser rundeck java -XX:MaxPermSize=256m -Xmx1024m -jar $RUNDECK_BIN -h >> /dev/stdout 2>&1
