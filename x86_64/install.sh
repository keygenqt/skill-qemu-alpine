#!/bin/bash
ALP_ARCH=x86_64
DISK_NAME="alpine.$ALP_ARCH.qcow2"
DISK_SIZE="8G"

#Get last release and iso file name
ALP_VIRT_LAST_ISO=$(wget -qO- "https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/$ALP_ARCH/latest-releases.yaml" | grep "iso: alpine-virt" | cut -d':' -f2- | tr -d '[:space:]')

ALP_VIRT_VERSION=$(echo $ALP_VIRT_LAST_ISO | cut -d'-' -f3)

#Display detected last-version of virt
echo "Last Alpine release for $ALP_ARCH version: $ALP_VIRT_VERSION  iso:$ALP_VIRT_LAST_ISO"
echo "Starting download.."

URL_DISTR="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/$ALP_ARCH/$ALP_VIRT_LAST_ISO"

# Download Alpine
if [ ! -f $(basename $URL_DISTR) ]; then
	wget $URL_DISTR
fi

# Create qemu disc
if [ ! -f "$DISK_NAME" ]; then
  qemu-img create -f qcow2 "$DISK_NAME" "$DISK_SIZE"
fi

# Run qemu
qemu-system-x86_64 -enable-kvm \
  -machine pc \
  -cpu host -smp cores=4 \
  -m 2048 \
  -cdrom $(basename $URL_DISTR) \
  -drive format=qcow2,file=$DISK_NAME \
  -nographic
