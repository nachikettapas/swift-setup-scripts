#!/bin/bash

SWIFT_USER=swift


su - ${SWIFT_USER} -c 'swift-init all stop'
