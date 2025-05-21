#!/bin/bash

IMG_FILE="./nixos2.img"
OVMF_CODE="/usr/share/OVMF/OVMF_CODE.fd"
OVMF_VARS="/usr/share/OVMF/OVMF_VARS.fd"

# Check if OVMF files exist after installing ovmf package
if [ ! -f "$OVMF_CODE" ] || [ ! -f "$OVMF_VARS" ]; then
  echo "OVMF firmware files not found. Please install with:"
  echo "sudo apt install ovmf"
  exit 1
fi

if [ -f "$IMG_FILE" ]; then
  # Boot existing VM image with UEFI
  qemu-system-x86_64 \
    -enable-kvm \
    -m 8192 \
    -cpu host \
    -smp 4 \
    -drive file=nixos2.img,format=qcow2

else
  # Create new VM image and boot from ISO with UEFI
  qemu-img create -f qcow2 nixos2.img 20G

  qemu-system-x86_64 \
    -enable-kvm \
    -m 8192 \
    -cpu host \
    -smp 4 \
    -boot d \
    -drive if=pflash,format=raw,readonly=on,file="$OVMF_CODE" \
    -drive if=pflash,format=raw,file="$OVMF_VARS" \
    -drive file=nixos2.img,format=qcow2 \
    -cdrom /home/leonardo//Downloads/nixos-minimal-24.11.717525.330d0a416792-x86_64-linux.iso
fi

# use ctrl-alt-G to go into grab mode (enables super key in vm)
