#!/bin/bash

##This is a one step setup script
sudo ./check_users.sh
./sys_swift_install_deps.sh
sudo ./sys_swift_setup.sh
sudo make_openrc.sh
