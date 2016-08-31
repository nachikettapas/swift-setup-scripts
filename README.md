# swift-setup-scripts
Order of execution for setting up swift:
Markup: 1. ./sys_swift_install_deps.sh
        2. sudo check_users.sh
        3. sudo sys_swift_setup.sh
        4. sudo cp openrc /home/swift
        5. sudo chown swift:swift /home/swift/openrc


#remove swift
sudo ./sys_swift_remove.sh
