#!/usr/bin/env bash

fallocate -l 256M alpine-rootfs
mkfs.ext4 alpine-rootfs

mkdir -p mount

sudo mount alpine-rootfs mount

sudo tar xf alpine-minirootfs-3.13.2-x86_64.tar.gz  -C mount  &> /dev/null
sudo tar xf openrc-0.42.1-r19.apk  -C mount &> /dev/null

# empty root password
sudo sed 's/^root:.*/root::14871::::::/' -i mount/etc/shadow

# faster package
sudo sed 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' -i mount/etc/apk/repositories

# default nameserver
echo 'nameserver 114.114.114.114' | sudo tee mount/etc/resolv.conf

# inittab
sudo cp inittab  mount/etc/inittab

sudo umount mount
