{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      prefer-no-csd = true;

      hotkey-overlay = {
        skip-at-startup = true;
      };

      layout = {
        background-color = "transparent";
        focus-ring = { enable = false; };
        border = { width = 2; };
        shadow = { enable = false; };
        gaps = 6;
        always-center-single-column = true;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length = { total-proportion = 0.1; };
        };

        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.50; }
          { proportion = 0.75; }
          { proportion = 1.00; }
        ];

        default-column-width = { proportion = 0.5; };
      };

      overview = {
        workspace-shadow = { enable = false; };
        backdrop-color = "transparent";
      };

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          natural-scroll = true;
          scroll-method = "two-finger";
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

      outputs = {
        "Virtual-1" = {
          scale = 1.0;
          position = { x = 0; y = 0; };
        };
      };

      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
      };
    };
  };
}
