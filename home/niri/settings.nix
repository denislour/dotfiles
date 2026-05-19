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
        focus-ring = {
          enable = true;
          width = 2;
        };
        gaps = 6;
        struts = {
          left = 4;
          right = 4;
          top = 30;
          bottom = 4;
        };

        # Preset column widths: dùng Alt+/ để chuyển
        preset-column-widths = [
          { proportion = 0.30; }   # 30%
          { proportion = 0.40; }   # 40%
          { proportion = 0.50; }   # 50%
          { proportion = 0.55; }   # 55%
          { proportion = 0.60; }   # 60%
          { proportion = 0.70; }   # 70%
        ];

        # Default width cho window mới
        default-column-width = { proportion = 0.5; };
      };

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          natural-scroll = true;
          scroll-method = "two-finger";
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = false;
      };

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
