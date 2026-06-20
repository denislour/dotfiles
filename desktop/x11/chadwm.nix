{ pkgs, ... }: {
  home.packages = with pkgs; [ chadwm rofi slock sysstat ];

  xdg.configFile."wallpaper".source = ../../system/wallpapers/emilia-01.webp;

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
        cpu_val=$(mpstat 1 1 | awk '/Average/ {printf "%.0f", 100 - $NF}')
        printf "^c$black^ ^b$green^   ^c$white^ ^b$grey^ ''${cpu_val:-0}%% ^b$black^"
      }

      mem() {
        mem_val=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
        printf "^c$black^ ^b$yellow^  ^c$white^ ^b$grey^ $mem_val ^b$black^"
      }

      clock() {
        printf "^c$black^ ^b$darkblue^ 󱑆 ^c$white^ ^b$grey^ $(date '+%H:%M') ^b$black^"
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
}
