{ ... }: {
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
      modules-center = [ "clock" ];
      modules-right = [
        "network"
        "pulseaudio"
        "cpu"
        "memory"
        "tray"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{name}";
        persistent_workspaces = {
          "1" = []; "2" = []; "3" = [];
          "4" = []; "5" = [];
        };
      };

      "clock" = {
        format = "{:%H:%M}";
        tooltip-format = "{:%A, %d %B %Y}";
        interval = 60;
      };

      "network" = {
        format-wifi = " {essid} ({signalStrength}%)";
        format-ethernet = " {ifname}";
        format-disconnected = " ⚠ Offline";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      };

      "pulseaudio" = {
        format = " {volume}%{icon}";
        format-icons = [ "" "" "" ];
        tooltip-format = "{desc} — {volume}%";
        on-click = "pavucontrol";
      };

      "cpu" = {
        format = " {usage}%";
        interval = 5;
      };

      "memory" = {
        format = " {}%";
        interval = 10;
      };
    }];
    style = ''
      * { font-family: "JetBrains Mono"; font-size: 13px; min-height: 0; }
      window#waybar { border-bottom: 1px solid rgba(255,255,255,0.1); }
      #workspaces button { padding: 0 6px; }
      #network, #pulseaudio, #cpu, #memory { padding: 0 8px; }
      #tray { padding: 0 4px; }
    '';
  };
}
