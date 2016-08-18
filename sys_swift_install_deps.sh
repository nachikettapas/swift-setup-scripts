#!/bin/sh
sudo apt-get update

#trusty backports mirror contains liberasurecode=dev
if ! grep -Fxq 'trusty-backports' /etc/apt/sources.list;
    then
        cat >> /etc/apt/sources.list << EOF
deb http://us.archive.ubuntu.com/ubuntu trusty-backports main universe
EOF
fi

sudo apt-get install -y curl
sudo apt-get install -y gcc
sudo apt-get install -y memcached
sudo apt-get install -y rsync
sudo apt-get install -y sqlite3
sudo apt-get install -y xfsprogs
sudo apt-get install -y git-core
sudo apt-get install -y libffi-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y liberasurecode-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y python-coverage
sudo apt-get install -y python-dev
sudo apt-get install -y python-nose
sudo apt-get install -y python-xattr
sudo apt-get install -y python-eventlet
sudo apt-get install -y python-greenlet
sudo apt-get install -y python-pastedeploy
sudo apt-get install -y python-netifaces
sudo apt-get install -y python-dnspython
sudo apt-get install -y python-mock

#ubuntu 14.04 comes with older pip version. We get the latest version here
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
