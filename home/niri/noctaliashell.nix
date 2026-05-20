{ inputs, config, ... }:

let
  wallpaperFile = ../../system/wallpapers/default.jpg;
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
        capsuleOpacity = 1;
        outerCorners = true;
        marginVertical = 4;
        marginHorizontal = 4;
        frameRadius = 12;
        backgroundOpacity = 0.93;
        displayMode = "always_visible";
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

      dock = {
        enabled = true;
        position = "bottom";
        displayMode = "auto_hide";
        dockType = "floating";
        floatingRatio = 1;
        size = 1;
        backgroundOpacity = 1;
        onlySameOutput = true;
        groupApps = false;
        showLauncherIcon = true;
        launcherPosition = "end";
        launcherUseDistroLogo = true;
        showDockIndicator = true;
        indicatorThickness = 3;
        indicatorColor = "primary";
        indicatorOpacity = 0.6;
        deadOpacity = 0.6;
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

  home.file.".local/share/noctalia/wallpapers/default.jpg".source = wallpaperFile;

  home.file.".cache/noctalia/wallpapers.json".text = builtins.toJSON {
    wallpapers = { "Virtual-1" = wallpaperPath; };
    defaultWallpaper = wallpaperPath;
  };
}
