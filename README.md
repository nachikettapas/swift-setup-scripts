# swift-setup-scripts
Order of execution for setting up swift:
* ./sys_swift_install_deps.sh
* sudo check_users.sh
* sudo sys_swift_setup.sh
* sudo cp openrc /home/swift
* sudo chown swift:swift /home/swift/openrc


#remove swift
* sudo ./sys_swift_remove.sh
