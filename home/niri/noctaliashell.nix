{ inputs, config, pkgs, ... }:

let
  wallpaperFile = ../../wallpapers/default.jpg;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "compact";
        position = "top";
        barType = "floating";
        showCapsule = true;
        widgets = {
          left = [
            { id = "Launcher"; }
            {
              id = "Clock";
              formatHorizontal = "HH:mm  ddd, MMM dd";
              formatVertical = "HH  mm";
              useMonospacedFont = true;
              usePrimaryColor = false;
            }
            { id = "SystemMonitor"; }
            { id = "ActiveWindow"; }
            { id = "MediaMini"; }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "index";
            }
          ];
          right = [
            { id = "Tray"; }
            { id = "NotificationHistory"; }
            { id = "Volume"; }
            {
              id = "ControlCenter";
              useDistroLogo = true;
              icon = "noctalia";
              enableColorization = true;
            }
          ];
        };
      };

      general = {
        avatarImage = "/home/${config.home.username}/.face";
      };

      colorSchemes.predefinedScheme = "Catppuccin-Lavender";

      network = { };

      # Disable Noctalia wallpaper management — let swaybg handle it
      wallpaper.enabled = false;
    };
  };

  # Copy wallpaper for swaybg
  home.file."Pictures/Wallpapers/default.jpg".source = wallpaperFile;
}
