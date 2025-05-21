#!/usr/bin/env bash

set -euo pipefail

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Use 'sudo' or log in as root." >&2
    exit 1
fi

echo "Starting NixOS full installation..."

## Disk Partitioning Section ##
DISK="/dev/sda"  # Using standard SATA disk

# Unmount any existing partitions
echo "Unmounting any existing partitions..."
umount -R /mnt 2>/dev/null || true

echo "Partitioning disk $DISK..."
parted "$DISK" -- mklabel gpt

# Create a 2GB EFI partition first (recommended for alignment)
parted "$DISK" -- mkpart ESP fat32 1MiB 2049MiB
parted "$DISK" -- set 1 esp on  # Set ESP flag on partition 1

# Create the main partition using remaining space
parted "$DISK" -- mkpart primary 2049MiB 100%

# Create filesystems
echo "Creating filesystems..."
mkfs.fat -F 32 -n boot "${DISK}1"  # First partition is ESP
mkfs.ext4 -L nixos "${DISK}2"      # Second partition is root

# Mount filesystems
echo "Mounting filesystems..."
mount "${DISK}2" /mnt
mkdir -p /mnt/boot
mount "${DISK}1" /mnt/boot

## NixOS Configuration Section ##

# Install git if not available
if ! command -v git &> /dev/null; then
    echo "Git not found, temporarily installing via nix-shell..."
    nix-shell -p git --command "echo 'Git is now available'"
fi

# Remove existing config directory if present
if [ -d "/mnt/etc/nixos" ]; then
    echo "Removing existing nixos configuration..."
    rm -rf /mnt/etc/nixos
fi

# Clone the configuration repo fresh
echo "Cloning nix-config repository..."
git clone https://github.com/Oldranda1414/nix-config /mnt/etc/nixos

# Generate hardware configuration
echo "Generating hardware configuration..."
nixos-generate-config --root /mnt

# Copy hardware configuration from temporary location
echo "Setting up hardware configuration..."
mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nixos/hardware-configuration.nix

# Build the system
if ! nixos-install --flake /mnt/etc/nixos#default; then
  echo "Installation failed. Check logs above for errors." >&2
  exit 1
fi

# Reboot the system
read -p "Installation complete! Reboot now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  reboot
fi