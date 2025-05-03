{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Oldranda1414";
    userEmail = "leonardorandacio@gmail.com"

    aliases = {
      st = "status -sb"; # Shows concise status
    };
  };
}
