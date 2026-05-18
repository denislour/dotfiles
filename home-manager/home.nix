{ lib, pkgs, ... }: {

  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    fastfetch
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
      main = {
        font = "JetBrains Mono:size=10";
      };
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

  # Waybar: cấu hình bằng Nix (best practice) vì tái sử dụng được, đồng bộ git
  # Module reference: https://github.com/Alexays/Waybar/wiki
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      spacing = 8;
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "network"
        "pulseaudio"
        "cpu"
        "memory"
        "tray"
      ];

      # Workspace config
      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{name}";
        persistent_workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
        };
      };

      # Clock
      "clock" = {
        format = "{:%H:%M}";
        tooltip-format = "{:%A, %d %B %Y}";
        interval = 60;
      };

      # Network
      "network" = {
        format-wifi = " {essid} ({signalStrength}%)";
        format-ethernet = " {ifname}";
        format-disconnected = " ⚠ Offline";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      };

      # Audio
      "pulseaudio" = {
        format = " {volume}%{icon}";
        format-icons = [ "" "" "" ];
        tooltip-format = "{desc} — {volume}%";
        on-click = "pavucontrol";
      };

      # CPU
      "cpu" = {
        format = " {usage}%";
        interval = 5;
      };

      # Memory
      "memory" = {
        format = " {}%";
        interval = 10;
      };
    }];

    style = ''
      * {
        font-family: "JetBrains Mono";
        font-size: 13px;
        min-height: 0;
      }
      window#waybar {
        background: rgba(0, 0, 0, 0.85);
        color: #c0caf5;
        border-bottom: 1px solid rgba(255,255,255,0.1);
      }
      #workspaces button {
        padding: 0 6px;
        color: #565f89;
      }
      #workspaces button.active {
        color: #7aa2f7;
        background: rgba(122, 162, 247, 0.15);
      }
      #workspaces button.urgent {
        color: #f7768e;
      }
      #clock {
        color: #a9b1d6;
      }
      #network, #pulseaudio, #cpu, #memory {
        padding: 0 8px;
      }
      #tray {
        padding: 0 4px;
      }
    '';
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/etc/nixos/wallpapers/default.png" ];
      wallpaper = [ ",/etc/nixos/wallpapers/default.png" ];
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "10x50";
        padding = 8;
        horizontal_padding = 8;
        frame_width = 2;
        frame_color = "#33ccff";
        separator_color = "frame";
        font = "JetBrains Mono 10";
        corner_radius = 5;
      };
      urgency_normal = {
        background = "#282a36";
        foreground = "#f8f8f2";
        timeout = 5;
      };
      urgency_low = {
        background = "#282a36";
        foreground = "#888888";
        timeout = 5;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#ffffff";
        timeout = 0;
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;  # UWSM handles systemd integration

    settings = {
      env = [
        # VMware compatibility
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "AQ_NO_ATOMIC,1"
        "AQ_NO_MODIFIERS,1"
        # Toolkit hints
        "GTK_THEME,Adwaita-dark"
        "NIXOS_OZONE_WL,1"
      ];

      exec-once = [
        "waybar"
        "hyprpaper"
        "nm-applet"
        "dunst"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(51ccffff)";
        "col.inactive_border" = "rgba(595959ff)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };

      bind = [
        # Terminal
        "SUPER, Q, exec, foot"
        # App launcher
        "SUPER, R, exec, rofi -show drun"
        # Close window
        "SUPER, W, killactive"
        # Fullscreen
        "SUPER, F, fullscreen"
        # Exit Hyprland
        "SUPER, M, exit"

        # Focus (vim-style)
        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"

        # Move windows
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, L, movewindow, r"

        # Workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"

        # Move to workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"

        # Screenshot
        ", Print, exec, grimblast copy area"
        "CTRL, Print, exec, grimblast copy output"
        "ALT, Print, exec, grimblast copy active"

        # Audio
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindm = [
        # Mouse: move/resize windows
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
