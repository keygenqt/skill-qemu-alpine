#!/bin/bash

URL_DISTR="https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86/alpine-virt-3.18.4-x86.iso"

DISK_NAME="alpine.x86.qcow2"
DISK_SIZE="8G"

# Download Alpine
if [ ! -f $(basename $URL_DISTR) ]; then
	wget $URL_DISTR
fi

# Create qemu disc
if [ ! -f "$DISK_NAME" ]; then
  qemu-img create -f qcow2 "$DISK_NAME" "$DISK_SIZE"
fi

# Run qemu
qemu-system-i386 -enable-kvm \
  -machine pc \
  -cpu kvm32 -smp cores=4 \
  -m 2048 \
  -cdrom $(basename $URL_DISTR) \
  -drive format=qcow2,file=$DISK_NAME \
  -nographic
