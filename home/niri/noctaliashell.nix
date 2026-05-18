{ inputs, config, ... }:

let
  wallpaperFile = ../../wallpapers/default.jpg;
  wallpaperPath = "/home/${config.home.username}/.local/share/noctalia/wallpapers/default.jpg";
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

      wallpaper = {
        enabled = true;
        directory = "/home/${config.home.username}/.local/share/noctalia/wallpapers";
      };
    };
  };

  # Copy wallpaper so Noctalia can find it
  home.file.".local/share/noctalia/wallpapers/default.jpg".source = wallpaperFile;

  # Set wallpaper via cache (format: { wallpapers: { <screen>: <path> }, defaultWallpaper: <path> })
  home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
    wallpapers = { "Virtual-1" = wallpaperPath; };
    defaultWallpaper = wallpaperPath;
  };
}
