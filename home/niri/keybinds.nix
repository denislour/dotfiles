{ pkgs, config, ... }:

let
  apps = import ./applications.nix { inherit pkgs; };
  noctalia = args: [ "noctalia-shell" "ipc" "call" ] ++ args;
in
{
  programs.niri.settings.binds = {

    "Alt+Return".action.spawn = [ apps.terminal ];
    "Alt+Space".action.spawn = noctalia [ "launcher" "toggle" ];
    "Alt+r".action.spawn = noctalia [ "launcher" "toggle" ];

    "Alt+q".action.close-window = { };
    "Alt+f".action.fullscreen-window = { };
    "Alt+t".action.toggle-window-floating = { };
    "Alt+m".action.quit = { };

    "Alt+o".action.toggle-overview = { };
    "Alt+Left".action.consume-or-expel-window-left = { };
    "Alt+Right".action.consume-or-expel-window-right = { };
    "Alt+comma".action.consume-window-into-column = { };
    "Alt+period".action.expel-window-from-column = { };
    "Alt+w".action.toggle-column-tabbed-display = { };

    "Alt+slash".action.switch-preset-column-width = { };
    "Alt+Shift+r".action.switch-preset-column-width-back = { };
    "Alt+minus".action.set-column-width = "-10%";
    "Alt+equal".action.set-column-width = "+10%";

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

    "XF86AudioRaiseVolume".action.spawn = noctalia [ "volume" "increase" ];
    "XF86AudioLowerVolume".action.spawn = noctalia [ "volume" "decrease" ];
    "XF86AudioMute".action.spawn = noctalia [ "volume" "muteOutput" ];
    "Shift+XF86AudioMute".action.spawn = noctalia [ "volume" "muteInput" ];

    "XF86AudioPlay".action.spawn = noctalia [ "media" "playPause" ];
    "XF86AudioNext".action.spawn = noctalia [ "media" "next" ];
    "XF86AudioPrev".action.spawn = noctalia [ "media" "previous" ];

    "Alt+Shift+q".action.spawn = noctalia [ "lockScreen" "lock" ];
  };
}
