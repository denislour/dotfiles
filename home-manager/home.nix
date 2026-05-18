{ lib, pkgs, ... }: {

  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    fastfetch
    polkit_gnome
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

  programs.foot = {
    enable = true;
    settings = {
      font = "JetBrains Mono:size=10";
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

  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      modules-left = [ "sway/workspaces" ];
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

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "rofi -show drun";
      bars = [ ];
      gaps = {
        inner = 8;
        outer = 8;
      };
      window = {
        border = 2;
        titlebar = false;
      };
      colors = {
        focused = {
          border = "#33ccff";
          background = "#33ccff";
          text = "#000000";
          indicator = "#33ccff";
          childBorder = "#33ccff";
        };
        focusedInactive = {
          border = "#33ccff";
          background = "#595959";
          text = "#ffffff";
          indicator = "#33ccff";
          childBorder = "#33ccff";
        };
        unfocused = {
          border = "#595959";
          background = "#595959";
          text = "#ffffff";
          indicator = "#595959";
          childBorder = "#595959";
        };
        urgent = {
          border = "#ff0000";
          background = "#ff0000";
          text = "#ffffff";
          indicator = "#ff0000";
          childBorder = "#ff0000";
        };
      };
      workspaceLayout = "tabbed";
      fonts = {
        names = [ "JetBrains Mono" ];
        style = "Normal";
        size = 10.0;
      };
      keybindings = let
        mod = "Mod4";
      in lib.mkOptionDefault {
        "${mod}+q" = "exec foot";
        "${mod}+r" = "exec rofi -show drun";
        "${mod}+w" = "kill";
        "${mod}+f" = "fullscreen";
        "${mod}+Shift+e" = "exit";
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "Print" = "exec grimblast copy area";
        "Ctrl+Print" = "exec grimblast copy output";
        "Alt+Print" = "exec grimblast copy active";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
    };
    extraConfig = ''
      # Wallpaper
      output * bg /etc/nixos/wallpapers/default.png fill

      # Startup
      exec waybar
      exec nm-applet

      # Input
      input "type:keyboard" {
          xkb_layout "us"
      }
      input "type:touchpad" {
          tap enabled
          natural_scroll enabled
      }

    '';
  };
}
