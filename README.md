# My nix-config

This repo contains my nix configuration files

## Usage

KEEP IN MIND THAT RUNNING THIS CONFIGURATION AS IS WILL SETUP YOUR SYSTEM TO MY CONFIGURATION, INCLUDING ALL MY USERS AND ACCOUNTS

To setup my configuration on a new NixOS installation:

ensure you have git installed (can install it temporarilly with nix-shell)

`nix-shell -p git`

clone the repo in your home directory

`git clone https://github.com/Oldranda1414/nix-config`

copy your hardware-configuration.nix file

`cp /etc/nixos/hardware-configuration.nix ~/nix-config/nixos/hardware-configuration.nix`

rebuild the system using the flake

`nixos-rebuild boot --flake ~/nix-config#default --use-remote-sudo`

after installing everything you should be prompted for the root password

reboot the system and on startup select the new generation

`reboot`

The system will now have my user and the default password is `12345`

### Common Problems

#### failed to start home-manager

This happens because home-manager needs to overwrite some file in home/user and it's afraid to do it so it just doesn't work

run the following command:

`journalctl -xe --unit home-manager-<user>`

where `<user>` is the name of the user that home manager failed to run for

This shows the files it tried to overwrite

Remove the conflicting files (or back them up by moving them somewhere else)

now running

`nixos-rebuild boot --flake ~/nix-config#default --use-remote-sudo`

should correctly create the new generation

### Check it out in vm

If you want to checkout my system just try it out in vm!

I recommend using qemu, a terminal based vm manager

Download the latest NixOS iso from the official site [click me to start the download](https://channels.nixos.org/nixos-24.11/latest-nixos-gnome-x86_64-linux.iso)

install qemu with your favourite package manager

`sudo apt install qemu`

create a new image file for the vm

`qemu-img create -f qcow2 nixos.img 20G`

```sh
  qemu-system-x86_64 \
    -enable-kvm \
    -m 8192 \
    -cpu host \
    -smp 4 \
    -boot d \
    -drive file=nixos.img,format=qcow2 \
    -cdrom path/to/iso \
```

where `path/to/iso` is the path to the downloaded iso file

follow install procedure in the vm

after the installation is done, poweroff the vm

then run the following to restart the vm with the installed system

```sh
  qemu-system-x86_64 \
    -enable-kvm \
    -m 8192 \
    -cpu host \
    -smp 4 \
    -boot c \
    -drive file=nixos.img,format=qcow2 \
```

now inside the vm follow the instructions in the [Usage](#usage) section to install my configuration.

## TODO

- restructure the repo to have a better layout
- add script to automate installation
- add waybar config in nix (<https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads>)
- fix hyprlock not working (<https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads>)
- configure oh-my-posh to look like oh-my-zsh (kinda done?)
- fix kitty transperency not working
- checkout <https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads> for inspiration
- test installtion script with curl -L `https://raw.githubusercontent.com/Oldranda1414/nix-config/main/install.sh`
- astronvim for easy plugin management or nixvim even better
- nvim 'jj' for escaping insert mode
- remap capslock to esc and home row mods with kanata
