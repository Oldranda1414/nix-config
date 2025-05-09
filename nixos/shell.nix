{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      # Handy alias for rebuilding system based on new config
      rebuild = "nixos-rebuild switch --flake ~/nix-config#default --use-remote-sudo";

      # Handy alias for backtracking
      ".." = "cd ..";

      # ls into exa (modern ls)
      ls = "eza --color=always --icons";
    };
    initContent = ''

      # keybindings {
        # Accept autosuggestion on ctrl + F
	bindkey -M viins '^F' autosuggest-accept
      # }
    
      # fzf {
        # Setting fzf theme to catpuccin-mocha (https://github.com/catppuccin/fzf)
	export FZF_DEFAULT_OPTS=" \
	--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
	--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
	--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
	--color=selected-bg:#45475a \
	--multi"

  # Setting fzf to use bat as default previewer
  export FZF_DEFAULT_OPTS="--preview='bat --color=always {}'"
      # }

      # bat { 
        # Setting bat theme
	export BAT_THEME=Nord
      # }

      # zoxide {
        # enable zoxide
        eval "$(zoxide init --cmd cd zsh)"
      # }

      # direnv {
        # direnv setup hook
	eval "$(direnv hook zsh)"
      # }
    '';
    zplug = { # For the list of options, please refer to Zplug README.
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

  home.packages = with pkgs; [
    # fuzzy finder
    fzf
    # modern cd
    zoxide
    # new and improved cat
    bat
    # shell extension environment
    direnv
    # modern ls
    eza
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    oh-my-posh = {
      enable = true;
      enableBashIntegration = true;
      # useTheme = "catppuccin_mocha";
      settings = builtins.fromJSON (builtins.readFile ./oh-my-posh.json);
    };
  };
}
