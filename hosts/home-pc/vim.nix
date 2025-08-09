{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    vimAlias = true;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    clipboard = {
      providers.xclip.enable = true;
      register = "unnamedplus";
    };

    opts = {
      number = true;
      relativenumber = true;
      # remove awkward shift when git info appears
      signcolumn = "yes";
      # have status line appear on every pane
      laststatus = 3;
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
      telescope = {
        enable = true;
        settings = {
          defaults = {
            layout_config.prompt_position = "top";
            sorting_strategy = "ascending";
          };
        };
      };
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
      # integration with treesitter
      treesitter.enable = true;
    };

    # keymaps
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      {
        key = "<leader>q";
        action = ":quitall<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Quit nvim";
        };
      }
      # Window navigation
      {
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          silent = true;
          noremap = true;
          desc = "Focus left window";
        };
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          silent = true;
          noremap = true;
          desc = "Focus right window";
        };
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          silent = true;
          noremap = true;
          desc = "Focus down window";
        };
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          silent = true;
          noremap = true;
          desc = "Focus up window";
        };
      }
      {
        mode = "n";
        key = "<Tab>";
        action = "<C-w>p";
        options = {
          silent = true;
          noremap = true;
          desc = "Focus previous window";
        };
      }
      # Nvim-Tree
      {
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle file explorer";
        };
      }
      # Telescope
      {
        key = "<leader>ff";
        action = ":Telescope find_files<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Search files";
        };
      }
      {
        key = "<leader>fw";
        action = ":Telescope live_grep<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Search grep";
        };
      }
      # Terminal buffer
      {
        key = "<leader>t";
        action = ":botright split | resize 15 | terminal<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Open terminal";
        };
      }
      {
        mode = "t";
        key = "<esc><esc>";
        action = "<C-\\><C-n>";
        options = {
          silent = true;
          noremap = true;
          desc = "Exit terminal mode";
        };
      }
      # Unset search
      {
        mode = "n";
        key = "<esc>";
        action = ":nohlsearch<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Remove search highlight";
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
    # necessary for telescope
    ripgrep
    fd
  ];

}
