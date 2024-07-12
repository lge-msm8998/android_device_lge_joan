#!/sbin/sh
#
# Copyright (C) 2020-2021 LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

echo "Checking if we are on a H932 (not H932PR). H932 requires specific graphics blobs."

# Check for toy/busybox
TOYBOX=/sbin/toybox
BUSYBOX=/sbin/busybox

mkdir -p /mnt/vendor

if test -f "$TOYBOX"; then
    toybox mount /dev/block/mapper/vendor -t ext4 /mnt/vendor
elif test -f "$BUSYBOX"; then
    busybox mount /dev/block/mapper/vendor -t ext4 /mnt/vendor
else
    /tmp/toybox mount /dev/block/mapper/vendor -t ext4 /mnt/vendor
fi

if cat /proc/cmdline | grep -q "LG-H932"; then
    echo "H932 detected, copying blobs..."
    mv /mnt/vendor/firmware/H932/* /mnt/vendor/firmware/
else
    echo "Not a H932, copy over the H930 specific graphics blobs"
    mv /mnt/vendor/firmware/H930/* /mnt/vendor/firmware/
fi

echo "Remove unneeded blobs"
rm -r /mnt/vendor/firmware/H930
rm -r /mnt/vendor/firmware/H932

echo "Set proper permissions for newly copied graphics blobs"
chmod 0644 /mnt/vendor/firmware/a540*
chown root:root /mnt/vendor/firmware/a540*
echo "including SELinux file contexts"
chcon u:object_r:firmware_file:s0 /mnt/vendor/firmware/a540*

if test -f "$TOYBOX"; then
    toybox umount /mnt/vendor
elif test -f "$BUSYBOX"; then
    busybox umount /mnt/vendor
else
    /tmp/toybox umount /mnt/vendor
fi
