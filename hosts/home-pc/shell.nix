{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      # Handy alias for rebuilding system based on new config
      rebuild = "nixos-rebuild switch --flake ~/nix-config --sudo";

      # Handy alias for backtracking
      ".." = "cd ..";

      # Handy alias to exit
      e = "exit";
    };
    initContent = ''

      # set neovim as manpager
      export MANPAGER='nvim +Man!'

      # keybindings {
        # Accept autosuggestion on ctrl + F
        bindkey -M viins '^F' autosuggest-accept
      # }
    '';
    zplug = { # For the list of options, refer to Zplug README.
      enable = true;
      plugins = [
	{
	  # git plugin
	  name = "plugins/git";
	  tags = [ from:oh-my-zsh ];
	}
	{
	  # zsh-vi-mode plugin
	  name = "jeffreytse/zsh-vi-mode";
	}
      ];
    };
  };

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [ "--preview='bat" "--color=always {}'"];
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromJSON (builtins.readFile ./oh-my-posh.json);
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      colors = "always";
      icons = "always";
      git = true;
    };
    bat = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      silent = true;
    };
  };
}
