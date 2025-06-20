# My nix-config

This repo contains my nix configuration files

## Usage

KEEP IN MIND THAT RUNNING THIS CONFIGURATION AS IS WILL SETUP YOUR SYSTEM TO MY CONFIGURATION, INCLUDING ALL MY USERS AND ACCOUNTS

To setup my configuration on a NEW NixOS installation:

`curl -L raw.githubusercontent.com/Oldranda1414/nix-config/main/install.sh | sudo bash`

On reboot you will be greeted with my configuration.

The user `randa` will be created with the password `12345`.

### Check it out in vm

If you want to checkout my system just try it out in vm!

The following guide will use `nix-shell` to have you use the dependencies in a temporary nix-shell.

Nix must be installed to use the `nix-shell` command [download](https://nixos.org/download/).

cd into the vm directory

`cd vm`

Download the latest NixOS iso from the official site [click me to start the download](https://channels.nixos.org/nixos-24.11/latest-nixos-gnome-x86_64-linux.iso)

Enter the temporary shell

`nix-shell`

Run the `run-vm.sh` script with root priviliges providing the path to the nixos-minimal iso

`./run-vm.sh /path/to/iso/nixos-minimal*.iso`

Install my configuration

`curl -L raw.githubusercontent.com/Oldranda1414/nix-config/main/install.sh | sudo bash`

After installing shutdown the vm

`poweroff`

Run the script again

`./run-vm.sh`

Now the vm should boot up to my configuration!

To start the vm subsequent times rerun the script (no need to provide the iso path again)

#### Cleanup

To remove all dependencies temporarily installed in the nix-shell session

`nix-store --gc`

## TODO

- restructure the repo to have a better layout
- add waybar config in nix (<https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads>)
- fix hyprlock not working (<https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads>)
- configure oh-my-posh to look like oh-my-zsh (kinda done?)
- checkout <https://gitlab.com/Zaney/zaneyos/-/tree/main?ref_type=heads> for inspiration
- add nixvim for nvim
- checkout qutebrowser and qtwebengine (keep chrome for now, qutebrowser gave me some problems on some websites, maybe because of add blocker)
- add steam for gaming
- fix stylix taking up so much space by disabeling auto enable and enabeling only for pkgs used
- find a better way to run the vm (should be doable from nix directly, no sh and qemu stuff directly)
- change host name
- test capability of having 2 users with different window managers
- add tmux
