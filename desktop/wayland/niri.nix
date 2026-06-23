{ config, pkgs, ... }:

let
  noctaliaMsg = args: [ "noctalia" "msg" ] ++ args;
in
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

        default-column-width = { proportion = 1.0; };
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
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
      };

      binds = {
        "Alt+Return".action.spawn = [ "${pkgs.ghostty}/bin/ghostty" ];
        "Alt+Space".action.spawn = noctaliaMsg [ "panel-toggle" "launcher" ];

        "Alt+q".action.close-window = { };
        "Alt+f".action.fullscreen-window = { };
        "Alt+Shift+f".action.set-column-width = "100%";
        "Alt+s".action.screenshot = { };
        "Alt+Shift+s".action.spawn = [ "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy" ];
        "Alt+t".action.toggle-window-floating = { };
        "Alt+m".action.move-column-to-workspace = 9;
        "Alt+Shift+m".action.focus-workspace = 9;

        "Alt+o".action.toggle-overview = { };
        "Alt+Left".action.consume-or-expel-window-left = { };
        "Alt+Right".action.consume-or-expel-window-right = { };
        "Alt+comma".action.spawn = noctaliaMsg [ "settings-toggle" ];
        "Alt+Shift+comma".action.consume-window-into-column = { };
        "Alt+period".action.expel-window-from-column = { };
        "Alt+w".action.toggle-column-tabbed-display = { };

        "Alt+minus".action.switch-preset-column-width-back = { };
        "Alt+equal".action.switch-preset-column-width = { };

        "Alt+Shift+minus".action.set-window-height = "-10%";
        "Alt+Shift+equal".action.set-window-height = "+10%";

        "Alt+Home".action.focus-column-first = { };
        "Alt+End".action.focus-column-last = { };

        "Alt+c".action.center-column = { };

        "Print".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        "Alt+h".action.focus-column-left = { };
        "Alt+j".action.focus-workspace-down = { };
        "Alt+k".action.focus-workspace-up = { };
        "Alt+l".action.focus-column-right = { };

        "Alt+Shift+h".action.move-column-left = { };
        "Alt+Shift+j".action.move-column-to-workspace-down = { };
        "Alt+Shift+k".action.move-column-to-workspace-up = { };
        "Alt+Shift+l".action.move-column-right = { };

        "Alt+1".action.focus-workspace = 1;
        "Alt+2".action.focus-workspace = 2;
        "Alt+3".action.focus-workspace = 3;
        "Alt+4".action.focus-workspace = 4;
        "Alt+5".action.focus-workspace = 5;

        "Alt+Shift+1".action.move-column-to-workspace = 1;
        "Alt+Shift+2".action.move-column-to-workspace = 2;
        "Alt+Shift+3".action.move-column-to-workspace = 3;
        "Alt+Shift+4".action.move-column-to-workspace = 4;
        "Alt+Shift+5".action.move-column-to-workspace = 5;

        "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
        "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
        "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        "Shift+XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];

        "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
        "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
        "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];

        "Alt+Shift+q".action.spawn = noctaliaMsg [ "session" "lock" ];
      };

      spawn-at-startup = [
        { command = [ "wl-clip-persist" "--clipboard" "both" ]; }
        { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
        { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }
        { command = [ "sh" "-c" "echo '' | ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --unlock" ]; }
        {
          command = [
            "sh" "-c"
            ''
              wp="${config.home.homeDirectory}/.local/share/noctalia/wallpapers/emilia-01.webp"
              i=0
              while [ ! -f "$wp" ] && [ $i -lt 10 ]; do
                sleep 0.5
                i=$((i + 1))
              done
              [ -f "$wp" ] && noctalia msg wallpaper-set "$wp"
            ''
          ];
        }
      ];

      window-rules = [
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

        {
          matches = [ { is-floating = true; } ];
          shadow = { enable = true; };
        }

        {
          matches = [ { title = "^Picture-in-Picture$"; } ];
          open-floating = true;
          default-floating-position = {
            x = 32;
            y = 32;
            relative-to = "bottom-right";
          };
          default-column-width = { fixed = 480; };
          default-window-height = { fixed = 270; };
        }

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
        {
          matches = [ { namespace = "^noctalia-wallpaper"; } ];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
