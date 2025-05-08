{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # defaultKeymap = "viins";
    shellAliases = {
      # Handy alias for rebuilding system based on new config
      rebuild = "nixos-rebuild boot --flake ~/nix-config#default --use-remote-sudo";

      # Handy alias for backtracking
      ".." = "cd ..";

      # ls into exa (modern ls)
      ls = "eza --color=always --icons";
    };
    initContent = ''

      # keybindings {
        # Accept autosuggestion on ctrl + F
	bindkey -M viins '^F' autosuggest-accept

	# Hook function
	#zle -N zle-keymap-select
      # }

      # powerlevel10k {
        source ~/.p10k.zsh
      # }
    
      # fzf {
        # Enable fxf keybindings and completion
	# TODO THIS DOES NOT WORK
        # [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

        # Setting fzf theme to catpuccin-mocha (https://github.com/catppuccin/fzf)
	export FZF_DEFAULT_OPTS=" \
	--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
	--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
	--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
	--color=selected-bg:#45475a \
	--multi"
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
	  # theming and stuff
          name = "romkatv/powerlevel10k";
          tags = [ as:theme depth:1 ]; 
        }
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # add p10k configuration
  home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;
}
