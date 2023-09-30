#!/bin/bash

DISK_NAME="alpine.aarch64.qcow2"

# Run qemu
qemu-system-aarch64 -accel tcg,thread=multi \
  -machine virt \
  -cpu cortex-a53 -smp cores=4 \
  -m 2048 \
  -bios AAVMF_CODE.fd \
  -nographic \
  -drive if=virtio,id=hd,format=qcow2,file=$DISK_NAME \
  -nic user,hostfwd=tcp::2222-:22,model=virtio \
  -device virtio-rng-pci \
  -rtc base=utc,clock=host
