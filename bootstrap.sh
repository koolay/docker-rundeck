#!/bin/sh
set -e

confd -backend env -onetime -confdir=/etc/confd
chown -R rundeck /etc/rundeck
service rundeckd restart
