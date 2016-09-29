#!/bin/bash


#Author: Paul Dardeau <paul.dardeau@intel.com>
#        Nandini Tata <nandini.tata@intel.com>
# Copyright (c) 2016 OpenStack Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

############################################
# Script to start all main services of Swift
############################################
SWIFT_USER="swift"
SWIFT_GROUP="swift"
SWIFT_USER_HOME="/home/${SWIFT_USER}"

su - ${SWIFT_USER} -c 'remakerings'
su - ${SWIFT_USER} -c "source ${SWIFT_USER_HOME}/openrc"
su - ${SWIFT_USER} -c 'startmain'
su - ${SWIFT_USER}
