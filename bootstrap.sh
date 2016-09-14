#!/bin/sh
set -e

echo "Asia/Shanghai" > /etc/timezone
confd -backend env -onetime -confdir=/etc/confd
chown -R rundeck /etc/rundeck && chown -R rundeck /var/rundeck && chown -R rundeck /var/lib/rundeck
service rundeckd restart
