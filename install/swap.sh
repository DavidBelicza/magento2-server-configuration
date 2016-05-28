#!/usr/bin/env bash

SWAP="/swapfile       none    swap    sw      0       0"

if grep -q $SWAP /etc/fstab; then
    echo "Swap has been set before"
else
    dd if=/dev/zero of=/swapfile bs=1024 count=256k
    mkswap /swapfile
    swapon /swapfile

    echo $SWAP >> /etc/fstab

    echo 10 | sudo tee /proc/sys/vm/swappiness
    echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf

    chown root:root /swapfile
    chmod 0600 /swapfile
fi;
