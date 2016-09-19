#Swift setup-scripts

A set of bash scripts with comments inline to install Swift All in One.
This setup mimics the layout of [SAIO - Swift All In One](http://docs.openstack.org/developer/swift/development_saio.html)

##One Step setup:

* ./one_step_setup.sh

The above will setup swift and also start services.
Next

##Order of execution for setting up swift using individual scripts:

1. ./sys_swift_install_deps.sh
2. sudo ./check_users.sh
3. sudo ./sys_swift_setup.sh
4. sudo ./make_openrc.sh
5. sudo ./start_swift.sh


##Remove Swift

1. sudo ./stop_swift.sh 
2. sudo ./sys_swift_remove.sh
