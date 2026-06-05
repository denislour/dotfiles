{ pkgs, lib, ... }:
let
  inherit (lib.generators) toINI;
  ini = toINI { };

  c = {
    bg = "#2d353b";
    fg = "#d3c6aa";
    mbg = "#f8f5e4";
    red = "#e67e80";
    blue = "#7fbbb3";
    green = "#a7c080";
    yellow = "#dbbc7f";
    orange = "#e69875";
    purple = "#d699b6";
    lime = "#B9C244";
    grey = "#272e33";
  };
in
{
  home.packages = with pkgs; [ polybar ];

  xdg.configFile."polybar/config.ini".text = ini {
    colors = {
      bg = c.bg;
      fg = c.fg;
      mbg = c.mbg;
      red = c.red;
      blue = c.blue;
      green = c.green;
      yellow = c.yellow;
      orange = c.orange;
      purple = c.purple;
      lime = c.lime;
      grey = c.grey;
    };

    "bar/main" = {
      monitor = "${env:MONITOR:}";
      monitor-strict = "false";
      override-redirect = "false";
      bottom = "false";
      fixed-center = "true";
      width = "98%";
      height = "23";
      offset-x = "1%";
      offset-y = "5";
      background = "${c.bg}";
      foreground = "${c.fg}";
      radius = "1";
      line-size = "2";
      line-color = "${c.blue}";
      border-size = "10";
      border-color = "${c.bg}";
      padding = "1";
      module-margin-left = "0";
      module-margin-right = "0";
      font-0 = "\"JetBrainsMono:style=Bold:size=9;2\"";
      font-1 = "\"Font Awesome 6 Free Solid:size=10;3\"";
      font-2 = "\"Material Design Icons Desktop:size=11;3\"";
      font-3 = "\"Material Design Icons Desktop:size=12;3\"";
      modules-left = "bspwm cpu memory filesystem";
      modules-center = "";
      modules-right = "network pulseaudio date tray";
      separator = "";
      dim-value = "1.0";
      wm-restack = "bspwm";
      enable-ipc = "true";
      cursor-click = "pointer";
      tray-position = "right";
    };

    "module/bspwm" = {
      type = "internal/bspwm";
      enable-click = "true";
      enable-scroll = "true";
      reverse-scroll = "true";
      pin-workspaces = "true";
      occupied-scroll = "false";
      format = "<label-state>";
      format-background = "${c.mbg}";
      format-font = "3";
      label-focused = "󰮯";
      label-focused-padding = "1";
      label-focused-foreground = "${c.orange}";
      label-occupied = "󰊠";
      label-occupied-padding = "1";
      label-occupied-foreground = "${c.purple}";
      label-urgent = "%icon%";
      label-urgent-padding = "0";
      label-empty = "󰑊";
      label-empty-padding = "1";
      label-empty-foreground = "${c.grey}";
    };

    "module/cpu" = {
      type = "internal/cpu";
      interval = "0.5";
      format = "<label>";
      format-prefix = "";
      format-prefix-padding = "1";
      format-prefix-font = "2";
      format-prefix-background = "${c.red}";
      format-prefix-foreground = "${c.mbg}";
      label = "%percentage%%";
      label-padding = "1";
      label-background = "${c.mbg}";
      label-foreground = "${c.grey}";
    };

    "module/memory" = {
      type = "internal/memory";
      interval = "3";
      format = "<label>";
      format-prefix = "";
      format-prefix-padding = "1";
      format-prefix-font = "2";
      format-prefix-background = "${c.blue}";
      format-prefix-foreground = "${c.mbg}";
      label = "%used%";
      label-padding = "1";
      label-background = "${c.mbg}";
      label-foreground = "${c.grey}";
    };

    "module/filesystem" = {
      type = "internal/fs";
      mount-0 = "/";
      interval = "60";
      fixed-values = "true";
      format-mounted = "<label-mounted>";
      format-mounted-prefix = "";
      format-mounted-prefix-padding = "1";
      format-mounted-prefix-font = "2";
      format-mounted-prefix-background = "${c.yellow}";
      format-mounted-prefix-foreground = "${c.mbg}";
      label-mounted = "%used%";
      label-mounted-padding = "1";
      label-mounted-background = "${c.mbg}";
      label-mounted-foreground = "${c.grey}";
      format-unmounted = "<label-unmounted>";
      format-unmounted-prefix = "";
      format-unmounted-prefix-padding = "1";
      format-unmounted-prefix-font = "2";
      format-unmounted-prefix-background = "${c.yellow}";
      format-unmounted-prefix-foreground = "${c.bg}";
      label-unmounted = "%mountpoint%: not mounted";
      label-unmounted-padding = "1";
      label-unmounted-background = "${c.mbg}";
      label-unmounted-foreground = "${c.grey}";
    };

    "module/date" = {
      type = "internal/date";
      interval = "1.0";
      time = "%I:%M %P";
      format-background = "${c.mbg}";
      format-foreground = "${c.grey}";
      date-alt = "\"%a, %d %b %Y\"";
      format = "<label>";
      format-prefix = "";
      format-prefix-padding = "1";
      format-prefix-font = "2";
      format-prefix-background = "${c.blue}";
      format-prefix-foreground = "${c.mbg}";
      label = "%time%%date%";
      label-padding = "1";
    };

    "module/network" = {
      type = "internal/network";
      interface-type = "wired";
      interval = "3.0";
      accumulate-stats = "true";
      unknown-as-up = "true";
      format-connected = "<label-connected>";
      format-connected-prefix = "";
      format-connected-prefix-font = "2";
      format-connected-prefix-padding = "1";
      format-connected-prefix-foreground = "${c.mbg}";
      format-connected-prefix-background = "${c.green}";
      label-connected = "%local_ip%";
      label-connected-padding = "1";
      label-connected-background = "${c.mbg}";
      label-connected-foreground = "${c.grey}";
      format-disconnected = "<label-disconnected>";
      format-disconnected-prefix = "";
      format-disconnected-prefix-font = "2";
      format-disconnected-prefix-padding = "1";
      format-disconnected-prefix-background = "${c.green}";
      format-disconnected-prefix-foreground = "${c.mbg}";
      label-disconnected = "Offline";
      label-disconnected-padding = "1";
      label-disconnected-background = "${c.mbg}";
      label-disconnected-foreground = "${c.grey}";
    };

    "module/pulseaudio" = {
      type = "internal/pulseaudio";
      interval = "5";
      use-ui-max = "true";
      format-volume = "<label-volume>";
      format-volume-prefix = "";
      format-volume-prefix-font = "2";
      format-volume-prefix-padding = "1";
      format-volume-prefix-background = "${c.orange}";
      format-volume-prefix-foreground = "${c.mbg}";
      label-volume = "%percentage%%";
      label-volume-padding = "1";
      label-volume-background = "${c.mbg}";
      label-volume-foreground = "${c.grey}";
      format-muted = "<label-muted>";
      format-muted-prefix = "";
      format-muted-prefix-font = "2";
      format-muted-prefix-padding = "1";
      format-muted-prefix-background = "${c.orange}";
      format-muted-prefix-foreground = "${c.mbg}";
      label-muted = "Muted";
      label-muted-padding = "1";
      label-muted-background = "${c.mbg}";
      label-muted-foreground = "${c.grey}";
      click-middle = "pavucontrol";
    };

    "module/tray" = {
      type = "internal/tray";
      format = "<tray>";
      format-background = "${c.bg}";
      tray-foreground = "${c.fg}";
      tray-spacing = "8";
      tray-padding = "0";
      tray-size = "70%";
    };
  };
}
