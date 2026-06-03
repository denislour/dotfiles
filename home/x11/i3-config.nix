{ pkgs, ... }:

let
  modifier = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      inherit modifier;

      gaps.inner = 6;
      gaps.outer = 0;

      focus.followMouse = true;

      bars = [
        {
          command = "${pkgs.polybar}/bin/polybar main";
        }
      ];

      keybindings = {
        "${modifier}+Return" = "exec ${pkgs.ghostty}/bin/ghostty";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+Space" = "exec ${pkgs.rofi}/bin/rofi -show run";
        "${modifier}+q" = "kill";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+t" = "floating toggle";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+Shift+1" = "move container to workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";
        "${modifier}+Shift+q" = "exec i3-nagbar -t warning -m 'Exit i3?' -b 'Yes' 'i3-msg exit'";
        "Print" = "exec ${pkgs.maim}/bin/maim ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";
        "Shift+Print" = "exec ${pkgs.maim}/bin/maim -s ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };

      assigns = {
        "9" = [
          { class = "pavucontrol"; }
          { class = "nm-connection-editor"; }
          { class = "blueman-manager"; }
        ];
      };

      floating = {
        criteria = [
          { class = "pavucontrol"; }
          { class = "nm-connection-editor"; }
          { class = "blueman-manager"; }
        ];
        titlebar = false;
      };
    };
  };

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom X11 compositor";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.picom}/bin/picom --config ${pkgs.writeText "picom.conf" ''
        fading = false;
        shadow = true;
        shadow-radius = 7;
        shadow-opacity = 0.35;
        shadow-offset-x = -7;
        shadow-offset-y = -7;
        inactive-dim = 0.2;
      ''}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.redshift = {
    Unit = {
      Description = "Redshift color temperature adjustment";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.redshift}/bin/redshift -t 4500:3500 -l 10.8:106.7";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
