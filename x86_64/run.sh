#!/bin/bash
ALP_ARCH=x86_64
DISK_NAME="alpine.$ALP_ARCH.qcow2"

PORT="2224"

# Run qemu
qemu-system-x86_64 -enable-kvm \
  -machine pc \
  -cpu host -smp cores=4 \
  -m 2048 \
  -nographic \
  -drive if=virtio,id=hd,format=qcow2,file=$DISK_NAME \
  -nic user,hostfwd=tcp::$PORT-:22,model=virtio \
  -device virtio-rng-pci \
  -rtc base=utc,clock=host
