# My nix-config

This repo contains my nix configuration files

## Usage

KEEP IN MIND THAT RUNNING THIS CONFIGURATION AS IS WILL SETUP YOUR SYSTEM TO MY CONFIGURATION, INCLUDING ALL MY USERS AND ACCOUNTS

To setup my configuration on a new NixOS installation:

`curl -L raw.githubusercontent.com/Oldranda1414/nix-config/main/install.sh | sudo bash`

### Common Problems

None for now :)

### Check it out in vm

If you want to checkout my system just try it out in vm!

The following guide will use `nix-shell` to have you use the dependencies in a temporary nix-shell.

Nix must be installed to use the `nix-shell` command.

cd into the vm directory

`cd vm`

Download the latest NixOS iso from the official site [click me to start the download](https://channels.nixos.org/nixos-24.11/latest-nixos-gnome-x86_64-linux.iso)

Enter the temporary shell

`nix-shell`

Run the `run-vm.sh` script with root priviliges providing the path to the nixos-minimal iso

`sudo run-vm.sh /path/to/iso/nixos-minimal*.iso`

Follow [Usage guide](#Usage)

After installing shutdown the run-vm

`poweroff`

Run the script again

`sudo run-vm.sh`

Now the vm should boot up to my configuration!

## TODO

- restructure the repo to have a better layout
- add script to automate installation
- add waybar config in nix (<https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads>)
- fix hyprlock not working (<https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads>)
- configure oh-my-posh to look like oh-my-zsh (kinda done?)
- fix kitty transperency not working
- checkout <https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads> for inspiration
- test installtion script with `curl -L https://raw.githubusercontent.com/Oldranda1414/nix-config/main/install.sh | sudo bash`
- astronvim for easy plugin management or nixvim even better
- nvim 'jj' for escaping insert mode
- remap capslock to esc and home row mods with kanata (<https://github.com/dreamsofcode-io/home-row-mods/tree/main>)
