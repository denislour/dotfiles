{ pkgs, ... }: {

  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    hyprpaper
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

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/etc/nixos/wallpapers/default.png" ];
      wallpaper = [ ",/etc/nixos/wallpapers/default.png" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
      ];
      exec-once = [
        "hyprpaper"
      ];
      input.kb_layout = "us";
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, foot"
        "$mod, W, killactive"
      ];
    };
  };
}
