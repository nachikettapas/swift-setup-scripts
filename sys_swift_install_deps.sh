#!/bin/sh

###################################################
#Script ot install all required dependencies before 
#installing Swift
###################################################

#trusty backports mirror contains liberasurecode=dev
apt-add-repository "deb http://us.archive.ubuntu.com/ubuntu trusty-backports main universe"

apt-get update
apt-get install -y curl
apt-get install -y gcc
apt-get install -y memcached
apt-get install -y rsync
apt-get install -y sqlite3
apt-get install -y xfsprogs
apt-get install -y git-core
apt-get install -y libffi-dev
apt-get install -y python-setuptools
apt-get install -y liberasurecode-dev
apt-get install -y libssl-dev
apt-get install -y python-coverage
apt-get install -y python-dev
apt-get install -y python-nose
apt-get install -y python-xattr
apt-get install -y python-eventlet
apt-get install -y python-greenlet
apt-get install -y python-pastedeploy
apt-get install -y python-netifaces
apt-get install -y python-dnspython
apt-get install -y python-mock

#ubuntu 14.04 comes with older pip version. We get the latest version here
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
