#!/bin/bash

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
umount /mnt/1/node/sdb1
umount /mnt/2/node/sdb2
umount /mnt/3/node/sdb3
umount /mnt/4/node/sdb4
umount /mnt/1/node/sdb5
umount /mnt/2/node/sdb6
umount /mnt/3/node/sdb7
umount /mnt/4/node/sdb8

# remove files and directories
rm -rf ${SWIFT_DISK_BASE_DIR}
rm -rf ${SWIFT_MOUNT_BASE_DIR}
rm -rf ${SWIFT_CONFIG_DIR}
rm -rf ${SWIFT_TMP_LOG_DIR}
rm -rf /run/swift
for x in {1..4}; do
   rm -rf ${SWIFT_CACHE_BASE_DIR}/swift${x}
done

echo "don't forget to manually remove entries from /etc/fstab"

