{ pkgs, lib, ... }:
let
  inherit (lib.generators) toINI;

  colors = {
    background = "#1e1e2e";
    background-alt = "#181825";
    foreground = "#cdd6f4";
    foreground-alt = "#a6adc8";
    primary = "#89b4fa";
    secondary = "#a6e3a1";
    urgent = "#f38ba8";
    surface = "#313244";
    overlay0 = "#6c7086";
    mantle = "#181825";
    red = "#f38ba8";
    teal = "#94e2d5";
  };

  ini = toINI { };
in
{
  home.packages = with pkgs; [
    polybar
    pavucontrol
    networkmanagerapplet
  ];

  xdg.configFile."polybar/config.ini".text = ini {
    colors = {
      background = colors.background;
      background-alt = colors.background-alt;
      foreground = colors.foreground;
      foreground-alt = colors.foreground-alt;
      primary = colors.primary;
      secondary = colors.secondary;
      urgent = colors.urgent;
      surface = colors.surface;
      overlay0 = colors.overlay0;
      mantle = colors.mantle;
      red = colors.red;
      teal = colors.teal;
    };

    "bar/main" = {
      width = "94%";
      height = "30";
      offset-x = "3%";
      offset-y = "4";
      radius = "14";
      radius-top = "14";
      radius-bottom = "14";
      fixed-center = "true";
      background = "${colors.background}";
      foreground = "${colors.foreground}";
      line-size = "1";
      line-color = "${colors.surface}";
      border-left-size = "0";
      border-right-size = "0";
      border-top-size = "2";
      border-bottom-size = "2";
      border-color = "${colors.surface}";
      padding-left = "12";
      padding-right = "12";
      module-margin-left = "2";
      module-margin-right = "2";
      font-0 = "\"JetBrainsMono Nerd Font:size=11;2\"";
      font-1 = "\"JetBrainsMono Nerd Font:style=Regular:size=11;2\"";
      font-2 = "\"Noto Sans:size=10;2\"";
      modules-left = "workspaces";
      modules-center = "date";
      modules-right = "pulseaudio network sys-tray";
      separator = " ";
      separator-foreground = "${colors.surface}";
      cursor-click = "pointer";
      enable-ipc = "true";
    };

    "module/workspaces" = {
      type = "internal/xworkspaces";
      label-active = "  %name%";
      label-active-background = "${colors.primary}";
      label-active-foreground = "${colors.mantle}";
      label-active-padding = "3";
      label-active-margin = "0 3";
      label-occupied = "  %name%";
      label-occupied-foreground = "${colors.foreground}";
      label-occupied-padding = "3";
      label-occupied-margin = "0 3";
      label-urgent = "  %name%";
      label-urgent-foreground = "${colors.mantle}";
      label-urgent-background = "${colors.red}";
      label-urgent-padding = "3";
      label-urgent-margin = "0 3";
      label-empty = "  %name%";
      label-empty-foreground = "${colors.overlay0}";
      label-empty-padding = "3";
      label-empty-margin = "0 3";
    };

    "module/date" = {
      type = "internal/date";
      interval = "1";
      date = "%a %b %d";
      date-alt = "%A %B %d %Y";
      time = "%H:%M";
      time-alt = "%H:%M:%S";
      format-prefix = " ";
      format-prefix-foreground = "${colors.teal}";
      format-foreground = "${colors.foreground}";
      label = "%date%  %time%";
    };

    "module/pulseaudio" = {
      type = "internal/pulseaudio";
      format-volume = "<label-volume>";
      format-volume-background = "${colors.surface}";
      format-volume-padding = "3";
      label-volume = "  %percentage%";
      label-volume-foreground = "${colors.foreground}";
      format-muted = "<label-muted>";
      format-muted-background = "${colors.surface}";
      format-muted-padding = "3";
      label-muted = "ﳌ  muted";
      label-muted-foreground = "${colors.overlay0}";
      click-middle = "pavucontrol";
    };

    "module/network" = {
      type = "internal/network";
      interface-type = "wired";
      format-connected = "<label-connected>";
      format-connected-background = "${colors.surface}";
      format-connected-padding = "3";
      label-connected = "  %local_ip%";
      label-connected-foreground = "${colors.foreground}";
      format-disconnected = "<label-disconnected>";
      format-disconnected-background = "${colors.surface}";
      format-disconnected-padding = "3";
      label-disconnected = "  no net";
      label-disconnected-foreground = "${colors.overlay0}";
    };

    "module/sys-tray" = {
      type = "internal/tray";
      tray-size = "16";
      tray-spacing = "6";
      tray-background = "${colors.surface}";
      tray-padding = "4";
    };
  };
}
