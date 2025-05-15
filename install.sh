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

# Create a 2GB EFI partition from 1MiB to 2049MiB (1MiB + 2048MiB = 2GB)
parted "$DISK" -- mkpart ESP fat32 1MiB 2049MiB
parted "$DISK" -- set 1 esp on  # Set ESP flag on partition 1

# Create the main partition starting right after the EFI partition
parted "$DISK" -- mkpart primary 2049MiB 100%

# Create filesystems
echo "Creating filesystems..."
mkfs.ext4 -L nixos "${DISK}1"
mkfs.fat -F 32 -n boot "${DISK}2"

# Mount filesystems
echo "Mounting filesystems..."
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

## NixOS Configuration Section ##

# Temporary install git if not available
if ! command -v git &> /dev/null; then
    echo "Git not found, temporarily installing via nix-shell..."
    nix-shell -p git --run "echo 'Git is now temporarily available'"
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
nixos-generate-config --root /mnt --dir /mnt

# Copy hardware configuration from temporary location
echo "Setting up hardware configuration..."
mv /mnt/hardware-configuration.nix /mnt/etc/nixos/nixos/hardware-configuration.nix

# Build the system
echo "Building system configuration (this may take a while)..."
sudo nixos-rebuild boot --flake /mnt/etc/nixos#default

# Reboot the system
echo "Installation complete! Rebooting the system..."
reboot