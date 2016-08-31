SWIFT_USER="swift"
SWIFT_GROUP="swift"

#verify that swift group exists
if grep -q ${SWIFT_GROUP} /etc/group; then
    echo "swift user group exists"
else
   groupadd ${SWIFT_GROUP}
    echo "swift user group has been created"
fi

#verify swift user exists
if grep -q ${SWIFT_USER} /etc/passwd; then
    echo "swift user exists"
else
   useradd -g ${SWIFT_GROUP} -m -s /bin/bash ${SWIFT_USER}
   echo "swift user has been created"
   #give  privileges to swift user and group
   echo "${SWIFT_GROUP} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
   adduser ${SWIFT_USER} sudo
   echo "swift user has been added to the  group"
fi
