#!/bin/bash


########################
# creates openrc file
#######################

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
   exit 1
fi

SWIFT_HOME_DIR=/home/swift
SWIFT_USER=swift

cd ${SWIFT_HOME_DIR}
echo  'export ST_AUTH=http://127.0.0.1:8080/auth/v1.0
export ST_USER=test:tester
export ST_KEY=testing' >openrc

chown ${SWIFT_USER}:${SWIFT_USER} openrc
