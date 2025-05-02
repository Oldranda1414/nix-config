{ lib, config, pkgs, ... }:

{
  options = {

  };

  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.randa = {
      isNormalUser = true;
      initialPassword = "12345";
      description = "Leonardo Randacio";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
      shell = pkgs.zsh;
      packages = with pkgs; [

      ];
    };

  };
}
