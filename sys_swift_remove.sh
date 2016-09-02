#!/bin/bash

###############################################
# Script to destoy environment created for Swift
################################################

#Ensures script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

SWIFT_DISK_BASE_DIR="/srv"
SWIFT_MOUNT_BASE_DIR="/mnt"

SWIFT_CONFIG_DIR="/etc/swift"
SWIFT_RUN_DIR="/var/run/swift"
SWIFT_CACHE_BASE_DIR="/var/cache"
SWIFT_TMP_LOG_DIR="/tmp/log/swift"

# unmount loopbacks
umount /mnt/sdb1

# remove files and directories
rm -rf ${SWIFT_DISK_BASE_DIR}
rm -rf ${SWIFT_MOUNT_BASE_DIR}
rm -rf ${SWIFT_CONFIG_DIR}
rm -rf ${SWIFT_TMP_LOG_DIR}
rm -rf ${SWIFT_RUN_DIR}
for x in {1..4}; do
   rm -rf ${SWIFT_CACHE_BASE_DIR}/swift${x}
done

echo "don't forget to manually remove entries from /etc/fstab"
