{ pkgs, lib, ... }:
let
  inherit (lib.generators) toINI;

  colors = {
    background = "#D91e1e2e";
    background-alt = "#181825";
    foreground = "#cdd6f4";
    foreground-alt = "#a6adc8";
    primary = "#89b4fa";
    secondary = "#a6e3a1";
    urgent = "#f38ba8";
    surface = "#22313244";
    overlay0 = "#6c7086";
    mantle = "#181825";
    red = "#f38ba8";
    teal = "#94e2d5";
    border = "#4A89b4fa";
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
      border = colors.border;
    };

    "bar/main" = {
      width = "62%";
      height = "32";
      offset-x = "19%";
      offset-y = "6";
      radius = "16";
      radius-top = "16";
      radius-bottom = "16";
      fixed-center = "false";
      background = "${colors.background}";
      foreground = "${colors.foreground}";
      line-size = "1";
      line-color = "${colors.border}";
      border-left-size = "1";
      border-right-size = "1";
      border-top-size = "1";
      border-bottom-size = "1";
      border-color = "${colors.border}";
      padding-left = "8";
      padding-right = "8";
      module-margin-left = "1";
      module-margin-right = "1";
      font-0 = "\"JetBrainsMono Nerd Font:size=11;2\"";
      font-1 = "\"JetBrainsMono Nerd Font:style=Regular:size=11;2\"";
      font-2 = "\"Noto Sans:size=10;2\"";
      modules-left = "workspaces";
      modules-center = "date";
      modules-right = "pulseaudio network";
      separator = " ";
      separator-foreground = "${colors.overlay0}";
      cursor-click = "pointer";
      enable-ipc = "true";
      tray-position = "none";
    };

    "module/workspaces" = {
      type = "internal/xworkspaces";
      label-active = "";
      label-active-background = "${colors.primary}";
      label-active-foreground = "${colors.mantle}";
      label-active-padding = "3";
      label-active-margin = "0 2";
      label-occupied = "";
      label-occupied-foreground = "${colors.foreground}";
      label-occupied-padding = "3";
      label-occupied-margin = "0 2";
      label-urgent = "";
      label-urgent-foreground = "${colors.mantle}";
      label-urgent-background = "${colors.red}";
      label-urgent-padding = "3";
      label-urgent-margin = "0 2";
      label-empty = "";
      label-empty-foreground = "${colors.overlay0}";
      label-empty-padding = "3";
      label-empty-margin = "0 2";
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
      label-muted = "ﳌ";
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
      label-disconnected = "";
      label-disconnected-foreground = "${colors.overlay0}";
    };
  };
}
