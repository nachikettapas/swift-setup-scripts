# swift-setup-scripts

One Step setup:
* ./one_step_setup.sh
The above will setup swift and also start services

Order of execution for setting up swift using individual scripts:
* ./sys_swift_install_deps.sh
* sudo ./check_users.sh
* sudo ./sys_swift_setup.sh
* sudo ./make_openrc.sh
* sudo ./start_swift.sh


#remove swift
* sudo ./stop_swift.sh 
* sudo ./sys_swift_remove.sh
