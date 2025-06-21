{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Oldranda1414";
    userEmail = "leonardorandacio@gmail.com";

    extraConfig = {
      alias = {
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
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = "true";
      };
      log = {
        abbrevCommit = "true";
	graphColors = "blue,yellow,cyan,magenta,green,red";
      };
      status = {
        branch = "true";
	showStash = "true";
	showUntrackedFiles = "all";
      };
      core = {
        editor = "nvim";
	pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = "true"; # use n and N to move between diff sections
	side-by-side = "true";

	# delta detects terminal colors automatically; set one of these to disable auto-detection
	# dark = true;
	# light = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved =  "default";
      };
      color.decorate = {
        HEAD = "red";
	branch = "blue";
	tag = "yellow";
	remoteBranch = "magenta";
      };
    };
  };

  home.packages = with pkgs; [
    # diff pager
    delta
  ];
}
