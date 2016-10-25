#!/bin/sh
set -e

confd -backend env -onetime -confdir=/etc/confd
