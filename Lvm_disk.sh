#!/bin/bash


/sbin/fdisk /dev/sdb<<EOF
n
p
1


t
L
8e
w
EOF

yum install lvm2 -y
mkdir /data
pvcreate /dev/sdb1
pvdisplay
vgcreate VolGroup /dev/sdb1
vgdisplay
lvcreate -l 100%FREE VolGroup -n lvdata
lvdisplay
mkfs.ext4 /dev/VolGroup/lvdata
mount /dev/VolGroup/lvdata /data