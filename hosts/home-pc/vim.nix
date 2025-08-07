{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    clipboard = {
      providers.xclip.enable = true;
      register = "unnamedplus";
    };

    plugins = {
      # status line
      lualine.enable = true;
      # file explorer
      nvim-tree = {
        enable = true;
        disableNetrw = true;
      };
      # icons for nvim-tree
      web-devicons.enable = true;
      # nix developer plugin
      nix.enable = true;
      # fuzzy find stuff
      telescope.enable = true;
      # code completion
      blink-cmp.enable = true;
      # keymapping hints
      which-key.enable = true;
      # git integration
      gitsigns.enable = true;
      # indent guides
      indent-blankline.enable = true;
      # insert pairs ()
      nvim-autopairs.enable = true;
      # auto save
      auto-save.enable = true;
    };

    # keymaps
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      # Nvim-Tree open file explorer
      {
        action = ":NvimTreeOpen<CR>";
        key = "<leader>e";
        options = {
          silent = true;
          noremap = true;
          desc = "Open explorer";
        };
      }
      # Telescope search files
      {
        action = ":Telescope find_files<CR>";
        key = "<leader>ff";
        options = {
          silent = true;
          noremap = true;
          desc = "Search files";
        };
      }
      # Telescope search (live grep)
      {
        action = ":Telescope live_grep<CR>";
        key = "<leader>fw";
        options = {
          silent = true;
          noremap = true;
          desc = "Search grep";
        };
      }
    ];

    autoGroups = {
      UserConfig = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = "TextYankPost";
        group = "UserConfig";
        callback.__raw = "function() vim.highlight.on_yank() end";
      }
    ];
  };

  home.packages = with pkgs; [
    # necessary for live_grep (Telescope plugin)
    ripgrep
  ];

}
