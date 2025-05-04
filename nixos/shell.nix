{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''

      # keybindings {
        bindkey -v
	bindkey -M viins '^F' autosuggest-accept
      # }
    
      # fxf {
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
        eval "$(zoxide init zsh)"
      # }

      # direnv {
        # direnv setup hook
	eval "$(direnv hook zsh)"
      # }
    '';
    plugins = [
      {
        name = "zsh-autosuggestions";
	src = pkgs.fetchFromGitHub {
	  owner = "zsh-users";
	  repo = "zsh-autosuggestions";
	  rev = "v0.4.0";
	  sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
	};
      }
      #{
      #  name = "zsh-syntax-highlighting";
      #}
    ];
    zplug = { # For the list of options, please refer to Zplug README.
      enable = true;
      plugins = [
        {
	  # theming and stuff
          name = "romkatv/powerlevel10k";
          tags = [ as:theme depth:1 ]; 
        }
	#{
	  # fuzzy finder
	#  name = "jhawthorn/fzy";
	#  tags = [ as:command rename-to:fzy hook-build:"make && sudo make install"];
	#}
	{
	  # git plugin
	  name = "plugins/git";
	  tags = [ from:oh-my-zsh ];
	}
	{
	  # syntax highlighting
	  name = "zsh-users/zsh-syntax-highlighting";
	  tags = [ defer:2 ];
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
  ];

  programs.fzf.enableZshIntegration = true;
}
