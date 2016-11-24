#!/bin/sh
set -e

echo "----start rundeck----"
java -Dserver.http.port=$SERVER_PORT -Xmx1024m -jar $RDECK_BIN -c /etc/rundeck -b $RDECK_BASE >> /dev/stdout 2>&1
