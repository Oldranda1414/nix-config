# My nix-config

This repo contains my nix configuration files

## Usage

To setup my configuration on a new NixOS installation:

ensure you have git installed (can install it with nix)

`nix-env -i git` THIS DOES NOT WORK TEMPORARILLY; PROBABLY SHOULD USE nix-shell INSTEAD

clone the repo in your home directory

`git clone https://github.com/Oldranda1414/nix-config`

copy your hardware-configuration.nix file

`cp /etc/nixos/hardware-configuration.nix ~/nix-config/nixos/hardware-configuration.nix`

rebuild the system using the flake

`nixos-rebuild switch --flake ~/nix-config#default --use-remote-sudo`

after installing everything you should be prompted for the root password

reboot the system and on startup select the new generation

`reboot`

### Common Problems

#### failed to start home-manager

This happens because home-manager needs to overwrite some file in home/user and it's afraid to do it so it just doesn't work

run the following command:

`journalctl -xe --unit home-manager-<user>`

where <user> is the name of the user that home manager failed to run for

This shows the files it tried to overwrite

Remove the conflicting files (or back them up by moving them somewhere else)

now running

`nixos-rebuild switch --flake ~/nix-config#default --use-remote-sudo`

should correctly create the new generation

#### Auto reboot to locked state

after running

`nixos-rebuild switch --flake ~/nix-config#default --use-remote-sudo`

the machine auto reboots and locks up

the generation has actually been creted so shutting down the machine and restarting manually will show the new generation anyway

### Check it out

If you want to checkout my system just try it out in vm!

I recommend using qemu, a terminal based vm manager

<!-- TODO ADD PRECISE COMMANDS -->
