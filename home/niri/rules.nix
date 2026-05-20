{ ... }:

{
  programs.niri.settings = {
    window-rules = [
      # Default rule: bo góc 20px cho mọi cửa sổ
      {
        matches = [ { } ];
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
        draw-border-with-background = false;
      }

      # Floating windows cũng bo góc, kèm shadow nhẹ
      {
        matches = [ { is-floating = true; } ];
        shadow = { enable = true; };
      }

      {
        matches = [
          { app-id = "^librewolf$"; }
        ];
        open-fullscreen = false;
      }

      # Picture-in-Picture window
      {
        matches = [
          { title = "^Picture-in-Picture$"; }
        ];
        open-floating = true;
        default-floating-position = {
          x = 32;
          y = 32;
          relative-to = "bottom-right";
        };
        default-column-width = { fixed = 480; };
        default-window-height = { fixed = 270; };
      }

      # Floating dialogs
      {
        matches = [
          { app-id = "^pavucontrol$"; }
          { app-id = "^nm-connection-editor$"; }
          { app-id = "^blueman-manager$"; }
          { app-id = "^xdg-desktop-portal-gtk$"; }
        ];
        open-floating = true;
      }
    ];

    layer-rules = [
      # Noctalia wallpaper hiển thị dưới nền
      {
        matches = [
          { namespace = "^noctalia-wallpaper"; }
        ];
        place-within-backdrop = true;
      }
    ];
  };
}
