{ config, pkgs, inputs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"  
      "nixpkgs"
      "-L"
    ];
  };
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 5d";
  };
  nix.optimise = {
    automatic = true;
  }
}
