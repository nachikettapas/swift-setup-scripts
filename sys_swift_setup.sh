#!/bin/bash

#*************  QUESTIONS  *************
# 1) /var/log/swift?
# 2) /var/cache/swift?
#***************************************

#if [[ $EUID -ne 0 ]]; then
#    echo "This script must be run as root" 1>&2
#   exit 1
#fi

SWIFT_USER="swift"
SWIFT_GROUP="swift"

SWIFT_DISK_SIZE_GB="1"
SWIFT_DISK_BASE_DIR="/srv"
SWIFT_MOUNT_BASE_DIR="/mnt"

SWIFT_CONFIG_DIR="/etc/swift"
SWIFT_RUN_DIR="/var/run/swift"
SWIFT_CACHE_BASE_DIR="/var/cache"
SWIFT_PROFILE_LOG_DIR="/tmp/log/swift/profile"

mkdir -p "${SWIFT_CONFIG_DIR}"
mkdir -p "${SWIFT_DISK_BASE_DIR}"
mkdir -p "${SWIFT_RUN_DIR}"
mkdir -p "${SWIFT_PROFILE_LOG_DIR}"

chown -R ${SWIFT_USER}:${SWIFT_GROUP} ${SWIFT_RUN_DIR}
chown -R ${SWIFT_USER}:${SWIFT_GROUP} ${SWIFT_PROFILE_LOG_DIR}

SWIFT_DISK="${SWIFT_DISK_BASE_DIR}/swift-disk"
truncate -s "${SWIFT_DISK_SIZE_GB}GB" "${SWIFT_DISK}"
mkfs.xfs -f "${SWIFT_DISK}"

# good idea to have backup of fstab before we modify it
cp /etc/fstab /etc/fstab.insert.bak

cat >> /etc/fstab << EOF
/srv/swift-disk /mnt/sdb1 xfs loop,noatime,nodiratime,nobarrier,logbufs=8 0 0
EOF

SWIFT_MOUNT_POINT_DIR="${SWIFT_MOUNT_BASE_DIR}/sdb1"
mkdir -p ${SWIFT_MOUNT_POINT_DIR}

mount -a 

for x in {1..4}; do
   echo "creating folders"
   mkdir "${SWIFT_MOUNT_POINT_DIR}/${x}"
done

for x in {1..4}; do
   SWIFT_DISK_DIR="${SWIFT_DISK_BASE_DIR}/${x}"
   SWIFT_MOUNT_DIR="${SWIFT_MOUNT_BASE_DIR}/sdb1/${x}"
   SWIFT_CACHE_DIR="${SWIFT_CACHE_BASE_DIR}/swift${x}"
   chown -R ${SWIFT_USER}:${SWIFT_GROUP} ${SWIFT_MOUNT_DIR}

   # necessary? used anywhere?
   mkdir -p "${SWIFT_CACHE_DIR}"

   ln -s ${SWIFT_MOUNT_DIR} ${SWIFT_DISK_DIR}
done

mkdir -p ${SWIFT_DISK_BASE_DIR}/1/node/sdb1
mkdir -p ${SWIFT_DISK_BASE_DIR}/2/node/sdb2
mkdir -p ${SWIFT_DISK_BASE_DIR}/3/node/sdb3
mkdir -p ${SWIFT_DISK_BASE_DIR}/4/node/sdb4

mkdir -p ${SWIFT_DISK_BASE_DIR}/1/node/sdb5
mkdir -p ${SWIFT_DISK_BASE_DIR}/2/node/sdb6
mkdir -p ${SWIFT_DISK_BASE_DIR}/3/node/sdb7
mkdir -p ${SWIFT_DISK_BASE_DIR}/4/node/sdb8

chown -R ${SWIFT_USER}:${SWIFT_GROUP} ${SWIFT_DISK_BASE_DIR}

# used by swift recon to dump the stats to cache
chown -R ${SWIFT_USER}:${SWIFT_GROUP} ${SWIFT_CACHE_BASE_DIR}

#*****************************************************************************

SWIFT_USER_HOME="/home/${SWIFT_USER}"
SWIFT_USER_BIN="${SWIFT_USER_HOME}/bin"
mkdir -p ${SWIFT_USER_BIN}

SWIFT_LOGIN_CONFIG="${SWIFT_USER_HOME}/.bashrc"

cd ${SWIFT_USER_HOME}
#EXPORT_BLOCK_DEVICE="export SAIO_BLOCK_DEVICE=${SWIFT_DISK}"
#grep "${EXPORT_BLOCK_DEVICE}" ${SWIFT_LOGIN_CONFIG}
#if [ "$?" -ne "0" ]; then
#    echo "${EXPORT_BLOCK_DEVICE}" >> ${SWIFT_LOGIN_CONFIG}
#fi


EXPORT_TEST_CFG_FILE="export SWIFT_TEST_CONFIG_FILE=${SWIFT_CONFIG_DIR}/test.conf"
grep "${EXPORT_TEST_CFG_FILE}" ${SWIFT_LOGIN_CONFIG}
if [ "$?" -ne "0" ]; then
   echo "${EXPORT_TEST_CFG_FILE}" >> ${SWIFT_LOGIN_CONFIG}
fi

SWIFT_REPO_DIR="${SWIFT_USER_HOME}/swift"
SWIFT_CLI_REPO_DIR="${SWIFT_USER_HOME}/python-swiftclient"

if [ -d ${SWIFT_USER_HOME}/swift ]; then
   su - ${SWIFT_USER} -c 'cd swift && git pull'
else
   su - ${SWIFT_USER} -c 'git clone https://github.com/openstack/swift'
fi

if [ -d ${SWIFT_USER_HOME}/python-swiftclient ]; then
   su - ${SWIFT_USER} -c 'cd python-swiftclient && git pull'
else
   su - ${SWIFT_USER} -c 'git clone https://github.com/openstack/python-swiftclient'
fi

EXPORT_PATH="export PATH=${PATH}:${SWIFT_USER_BIN}"
grep "${EXPORT_PATH}" ${SWIFT_LOGIN_CONFIG}
if [ "$?" -ne "0" ]; then
   echo "${EXPORT_PATH}" >> ${SWIFT_LOGIN_CONFIG}
fi

echo "export PYTHONPATH=${SWIFT_USER_HOME}/swift" >> ${SWIFT_LOGIN_CONFIG}

cp ${SWIFT_REPO_DIR}/test/sample.conf ${SWIFT_CONFIG_DIR}/test.conf

cd ${SWIFT_REPO_DIR}/doc/saio/swift; cp -r * ${SWIFT_CONFIG_DIR}; cd -
chown -R ${SWIFT_USER}:${SWIFT_GROUP} ${SWIFT_CONFIG_DIR}
find ${SWIFT_CONFIG_DIR}/ -name \*.conf | xargs sed -i "s/<your-user-name>/${SWIFT_USER}/"

cp ${SWIFT_REPO_DIR}/doc/saio/rsyslog.d/10-swift.conf /etc/rsyslog.d/
sed -i '2 s/^#//' /etc/rsyslog.d/10-swift.conf

cd ${SWIFT_REPO_DIR}/doc/saio/bin; cp * ${SWIFT_USER_BIN}; cd -

#TODO: can this could be made better? (handle other paths)
sed -i "/find \/var\/log\/swift/d" ${SWIFT_USER_BIN}/resetswift

cd ${SWIFT_CLI_REPO_DIR}
pip install -r requirements.txt
pip install -r test-requirements.txt
pip install -U pip tox pbr virtualenv setuptools
apt-get install libpython3.4-dev
python setup.py develop

cd ${SWIFT_REPO_DIR}
pip install -r requirements.txt
pip install -r test-requirements.txt
pip install PyECLib
python setup.py develop
apt-get remove python-six
pip install -U six
