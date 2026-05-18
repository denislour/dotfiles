{ ... }: {

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/etc/nixos/wallpapers/default.jpg" ];
      wallpaper = [ ",/etc/nixos/wallpapers/default.jpg" ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_input = true;
        no_fade_in = false;
      };
      input-field = [{
        size = "300, 60";
        outline_thickness = 3;
        dots_size = 0.3;
        dots_spacing = 0.4;
        dots_center = true;
        position = "0, -100";
        halign = "center";
        valign = "center";
      }];
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
        separator_color = "frame";
        font = "JetBrains Mono 10";
        corner_radius = 5;
      };
      urgency_normal = { timeout = 5; };
      urgency_low = { timeout = 5; };
      urgency_critical = { timeout = 0; };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      env = [
        "AQ_NO_ATOMIC,1"
        "AQ_NO_MODIFIERS,1"
        "GTK_THEME,Adwaita-dark"
        "NIXOS_OZONE_WL,1"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
      ];

      exec-once = [
        "waybar"
        "hyprpaper"
        "nm-applet"
        "dunst"
      ];

      cursor = {
        no_hardware_cursors = true;
      };

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
        layout = "dwindle";
      };

      decoration = {
        rounding = 3;
        blur = { enabled = false; };
        shadow = { enabled = false; };
      };

      animations = { enabled = false; };

      dwindle = { preserve_split = true; };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      bind = [
        "SUPER, Q, exec, foot"
        "SUPER, R, exec, rofi -show drun"
        # Reload wallpaper
        "SUPER SHIFT, R, exec, killall hyprpaper && hyprpaper"
        "SUPER, W, killactive"
        "SUPER, F, fullscreen"
        "SUPER, M, exit"

        "SUPER SHIFT, L, exec, hyprlock"

        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"

        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, L, movewindow, r"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"

        ", Print, exec, grimblast copy area"
        "CTRL, Print, exec, grimblast copy output"
        "ALT, Print, exec, grimblast copy active"

        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
