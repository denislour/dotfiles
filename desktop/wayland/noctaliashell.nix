{ config, ... }:

let
  homeDir = config.home.homeDirectory;
  wallpaperFile = ../../system/wallpapers/emilia-01.webp;
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
        clipboard_enabled = true;
        avatar_path = "${homeDir}/.face";

        panel = {
          transparency_mode = "solid";
          borders = true;
          shadow = true;
          launcher_placement = "centered";
          clipboard_placement = "centered";
          control_center_placement = "attached";
          wallpaper_placement = "attached";
          session_placement = "attached";
        };
      };

      wallpaper = {
        enabled = true;
        directory = "${homeDir}/Pictures/Wallpapers";
        fill_mode = "crop";
        transition = ["fade" "wipe" "disc" "stripes" "zoom" "honeycomb"];
        transition_duration = 1500;
        edge_smoothness = 0.3;

        default.path = toString wallpaperFile;
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Ayu";
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
        scale = 1.0;
        shadow = true;
        auto_hide = false;
        reserve_space = true;
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
        main_axis_padding = 16;
        cross_axis_padding = 8;
        item_spacing = 6;
        background_opacity = 1.0;
        radius = 16;
        margin_h = 0;
        margin_v = 8;
        shadow = true;
        show_running = true;
        auto_hide = true;
        reserve_space = false;
        magnification = true;
        magnification_scale = 1.45;
        active_scale = 1.0;
        inactive_scale = 0.85;
        active_opacity = 1.0;
        inactive_opacity = 0.85;
        show_dots = true;
        show_instance_count = false;
        launcher_position = "end";
        launcher_icon = "grid-dots";
        active_monitor_only = true;
        pinned = [ ];
      };
    };
  };
}
