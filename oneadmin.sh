#!/bin/bash 

echo 'oneadmin:opennebula' > ~/.one/one_auth

cat /dev/zero | ssh-keygen -q -N ""
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
ssh-keyscan -H localhost >> ~/.ssh/known_hosts

usermod -aG lxd oneadmin
usermod -aG kvm oneadmin

adduser oneadmin sudo
cat << EOF > /etc/sudoers.d/opennebula 
Defaults:oneadmin !requiretty
Defaults:oneadmin secure_path = /sbin:/bin:/usr/sbin:/usr/bin

oneadmin ALL=(ALL) NOPASSWD: /bin/true, /bin/false
EOF
