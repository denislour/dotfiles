{ pkgs, ... }: {

  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    hyprpaper
    waybar
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

  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "tray" ];
    }];
    style = ''
      * {
        font-family: "JetBrains Mono";
        font-size: 13px;
      }
      window#waybar {
        background: rgba(0, 0, 0, 0.8);
        color: #ffffff;
      }
      #workspaces button.active {
        background: #6272a4;
      }
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "AQ_NO_ATOMIC,1"
        "AQ_NO_MODIFIERS,1"
      ];
      exec-once = [
        "hyprpaper"
        "waybar"
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
