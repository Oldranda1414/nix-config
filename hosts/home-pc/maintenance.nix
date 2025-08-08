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

  nix.optimise.automatic = true;

  # Override the nixos-upgrade service to wait for network and delay
  systemd.services.nixos-upgrade = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    # serviceConfig.ExecStartPre = [
    #   # Wait 5 seconds before starting upgrade
    #   "${pkgs.coreutils}/bin/sleep 5"
    # ];
  };
}
