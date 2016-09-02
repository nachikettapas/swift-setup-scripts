#!/bin/bash

SWIFT_USER=swift

su - ${SWIFT_USER} -c 'remakerings'
su - ${SWIFT_USER} -c 'source /home/swift/openrc'
su - ${SWIFT_USER} -c 'startmain'
su - ${SWIFT_USER}
