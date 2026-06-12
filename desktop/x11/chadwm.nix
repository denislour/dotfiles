{ pkgs, ... }: {
  home.packages = with pkgs; [ chadwm i3lock rofi sxhkd picom dunst ];

  xdg.configFile."wallpaper".source = ../../system/wallpapers/emilia-01.webp;

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom compositor";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.picom}/bin/picom --backend xrender";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.sxhkd = {
    Unit = {
      Description = "SXHKD hotkey daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."chadwm/bar.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ${pkgs.feh}/bin/feh --bg-fill "$HOME/.config/wallpaper"

      fg=#e0def4
      bg=#232136
      black=#111827
      green=#A8C5B3
      white=#E6EDF3
      grey=#303542
      blue=#A5B4FC
      red=#FCA5A5
      darkblue=#7f92ee
      yellow=#f9e2af

      cpu() {
        cpu_val=$(ps -eo pcpu --no-headers 2>/dev/null | awk -v c=$(nproc) '{s+=$1} END{printf "%.0f", s/c}')
        [ -z "$cpu_val" ] && cpu_val=0
        printf "^c$black^ ^b$green^   ^c$white^ ^b$grey^ $cpu_val%% ^b$black^"
      }

      mem() {
        mem_val=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
        printf "^c$black^ ^b$yellow^  ^c$black^ ^b$grey^ $mem_val ^b$black^"
      }

      clock() {
        printf "^c$black^ ^b$darkblue^ 󱑆 ^c$black^ ^b$blue^ $(date '+%H:%M') ^b$black^"
      }

      while true; do
        xsetroot -name "$(cpu) $(mem) $(clock)"
        sleep 1
      done
    '';
  };

  systemd.user.services.chadwm-bar = {
    Unit = {
      Description = "Chadwm status bar";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.bash}/bin/bash %h/.config/chadwm/bar.sh";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."chadwm/autostart.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      ${pkgs.feh}/bin/feh --bg-fill "$HOME/.config/wallpaper" &
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
    '';
  };

  xdg.configFile."sxhkd/sxhkdrc".text = ''
    mod1 + Return
      alacritty

    mod1 + space
      rofi -show drun

    mod1 + s
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    mod1 + shift + s
      maim -s ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    Print
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    mod1 + shift + q
      i3lock

    XF86AudioRaiseVolume
      pactl set-sink-volume @DEFAULT_SINK@ +5%

    XF86AudioLowerVolume
      pactl set-sink-volume @DEFAULT_SINK@ -5%

    XF86AudioMute
      pactl set-sink-mute @DEFAULT_SINK@ toggle

    XF86AudioPlay
      playerctl play-pause

    XF86AudioNext
      playerctl next

    XF86AudioPrev
      playerctl previous
  '';
}
