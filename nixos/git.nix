{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Oldranda1414";
    userEmail = "leonardorandacio@gmail.com";

    aliases = {
      st = "status -sb"; # Shows concise status
      last = "log -1 HEAD --stat"; # Shows last commit with file changes
      cm = "commit -m"; # Shortens commit command
      gl = "config --global -l"; # Lists global Git configs
      acm = "!git add . && git commit -am"; # Shortens add all changes and commit
      lol = "log --oneline"; # Summary of git log
      pushup = "push -u origin HEAD"; # Sets upstream for new branches
      alias = "! git config --get-regexp ^alias\\. | sed -e s/^alias\\.// -e s/\\ /\\ =\\ /"; # Pretty list all git aliases
      graph = "log --graph --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n'"; # Pretty graph log
    };
  };
}
