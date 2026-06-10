{ config, ... }:

let
  homeDir = config.home.homeDirectory;
  wallpaperFile = ../../system/wallpapers/default.jpg;
in
{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      shell = {
        ui_scale = 1.0;
        corner_radius_scale = 2;
        font_family = "sans-serif";
        time_format = "{:%H:%M}";
        date_format = "%A, %x";
        settings_show_advanced = false;
        avatar_path = "${homeDir}/.face";
        clipboard_enabled = true;
      };

      bar.main = {
        position = "top";
        thickness = 34;
        background_opacity = 0.88;
        radius = 12;
        margin_h = 4;
        margin_v = 4;
        padding = 14;
        widget_spacing = 6;
        shadow = true;
        auto_hide = false;
        capsule = true;
        capsule_opacity = 1.0;

        start = [ "launcher" "workspaces" ];
        center = [ "clock" ];
        end = [ "media" "tray" "notifications" "clipboard" "network" "bluetooth" "volume" "brightness" "battery" "control-center" "session" ];
      };

      dock = {
        enabled = true;
        position = "bottom";
        icon_size = 48;
        background_opacity = 1.0;
        radius = 16;
        margin_h = 0;
        margin_v = 8;
        shadow = true;
        show_running = true;
        auto_hide = true;
        magnification = true;
        magnification_scale = 1.45;
        show_dots = true;
        show_instance_count = false;
        launcher_position = "end";
        launcher_icon = "grid-dots";
        active_monitor_only = true;
        pinned = [ ];
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Ayu";
      };

      wallpaper = {
        enabled = true;
        directory = "${homeDir}/.local/share/noctalia/wallpapers";
      };
    };
  };

  home.file.".local/share/noctalia/wallpapers/default.jpg".source = wallpaperFile;
}
