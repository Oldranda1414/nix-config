{ pkgs, lib, ... }:

let
  mod = "Mod4";
  term = {
    run = "kitty";
    key = "Return";
  };
  menu = {
    run = "rofi --show drun";
    key = "d";
  };
  browser = {
    run = "google-chrome-stable";
    key = "Shift+Return";
  };
  movement = {
    left = "h";
    down = "j";
    up = "k";
    right = "l";
  };
  barPosition = "top";
  workspaces = [
    { name = "1"; key = "1";}
    { name = "2"; key = "2";}
    { name = "3"; key = "3";}
    { name = "4"; key = "4";}
    { name = "5"; key = "5";}
    { name = "6"; key = "6";}
    { name = "7"; key = "7";}
    { name = "8"; key = "8";}
    { name = "9"; key = "9";}
    { name = "10"; key = "0";}
  ];
in {
  home.packages = with pkgs; [
    # application launcher
    rofi
    # file explorer
    yazi
  ];

  programs.kitty = {
    enable = true;
    # settings = {
    #   background_opacity = lib.mkDefault 0.8;
    #   enable_blur = true;
    # };
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = mod;
      keybindings = {
        "${mod}+${term.key}" = "exec ${term.run}";
        "${mod}+${menu.key}" = "exec ${menu.run}";
        "${mod}+${browser.key}" = "exec ${browser.run}";
      }
      //
      builtins.listToAttrs (
	builtins.concatLists (map (workspace:
	  [
	    {
	      name = "${mod}+${workspace.key}";
	      value = "workspace ${workspace.name}";
	    }
	    {
	      name = "${mod}+Shift+${workspace.key}";
	      value = "move container to workspace ${workspace.name}; workspace ${workspace.name}";
	    }
	  ]
	) workspaces)
      );
      gaps = {
        inner = 10;
        outer = 5;
      };
    };
  };
}
