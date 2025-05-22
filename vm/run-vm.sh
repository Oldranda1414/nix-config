#!/bin/bash

IMG_FILE="./nixos.img"

if [ -f "$IMG_FILE" ]; then
  # Boot existing VM image with UEFI
  qemu-system-x86_64 \
    -enable-kvm \
    -m 8192 \
    -cpu host \
    -smp 4 \
    -drive file=$IMG_FILE,format=qcow2

else

  ISO_PATH="$1"
  OVMF_CODE="/usr/share/OVMF/OVMF_CODE.fd"
  OVMF_VARS="/usr/share/OVMF/OVMF_VARS.fd"

  # Check if OVMF files exist
  if [ ! -f "$OVMF_CODE" ] || [ ! -f "$OVMF_VARS" ]; then
    echo "❌ OVMF firmware files not found."
    echo "Please run the `nix-shell` command"
    exit 1
  fi

  # Check for ISO path argument
  if [ -z "$ISO_PATH" ]; then
    echo "❌ Please provide the path to the NixOS ISO."
    echo "Usage: $0 /path/to/nixos.iso"
    exit 1
  fi

  # Create new VM image and boot from ISO with UEFI
  qemu-img create -f qcow2 $IMG_FILE 20G

  qemu-system-x86_64 \
    -enable-kvm \
    -m 8192 \
    -cpu host \
    -smp 4 \
    -boot d \
    -drive if=pflash,format=raw,readonly=on,file="$OVMF_CODE" \
    -drive if=pflash,format=raw,file="$OVMF_VARS" \
    -drive file=$IMG_FILE,format=qcow2 \
    -cdrom $ISO_PATH
fi

