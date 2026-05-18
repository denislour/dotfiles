{ pkgs, ... }: {

  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
  ];

  programs.git = {
    enable = true;
    userName = "Lektor";
    userEmail = "Lektor@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      alias ll='ls -la'
      alias la='ls -A'
      alias v='vim'
      alias g='git'
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input.kb_layout = "us";
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, foot"
        "$mod, W, killactive"
      ];
    };
  };
}
