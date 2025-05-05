# My nix-config

This repo contains my nix configuration files

## Usage

To setup my configuration on a new NixOS installation:

ensure you have git installed (can install it with nix)

`nix-env -i git`

clone the repo in your home directory

`git clone https://github.com/Oldranda1414/nix-config`

copy your hardware-configuration.nix file

`cp /etc/nixos/hardware-configuration.nix ~/nix-config/nixos/hardware-configuration.nix`

rebuild the system using the flake

`nixos-rebuild switch --flake ~/nix-config#default --use-remote-sudo`

after installing everything you should be prompted for the root password

reboot the system and on startup select the new generation

`reboot`

### Check it out

If you want to checkout my system just try it out in vm!

I recommend using qemu, a terminal based vm manager

<!-- TODO ADD PRECISE COMMANDS -->
