#!/bin/bash

arch_sys=$(uname -a)
echo "#Architecture: $arch_sys"

nbCPU=$(nproc)
echo "#CPU physical : $nbCPU"

nbVCPU=$(cat /proc/cpuinfo | grep -i "processor" | wc -l)
echo "#vCPU"

free -m | awk 'NR==2{printf "#Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NG=="/"{printf "#Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
top -bn1 | grep load | awk '{printf "#CPU Load: %.2f\n", $(NF-2}'

last_boot=$(who -b | cut -c23-)
echo "#Last boot: $last_boot"

if grep -Pq '/dev/(mapper/|disk/by-id/dm' /etc/fstab || mount | grep -q /dev/mapper/
then
    echo "#LVM use: yes"
else
    echo "#LVM use: no"
fi