{ pkgs, config, ... }:

let
  noctalia = cmd: [ "noctalia-shell" "ipc" "call" ] ++ (builtins.splitString " " cmd);
in
{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Terminal & Launcher
    "Super+Return".action.spawn = [ "${pkgs.ghostty}/bin/ghostty" ];
    "Super+Space".action.spawn = noctalia "launcher toggle";
    "Super+r".action.spawn = noctalia "launcher toggle";

    # Window operations
    "Super+q".action = close-window;
    "Super+f".action = fullscreen-window;
    "Super+t".action = toggle-window-floating;
    "Super+m".action = quit;

    # Screenshot
    "Print".action.screenshot = [ ];
    "Ctrl+Print".action.screenshot-screen = [ ];
    "Alt+Print".action.screenshot-window = [ ];

    # Focus movement (Vim keys)
    "Super+h".action = focus-column-left;
    "Super+j".action = focus-workspace-down;
    "Super+k".action = focus-workspace-up;
    "Super+l".action = focus-column-right;

    # Move windows
    "Super+Shift+h".action = move-column-left;
    "Super+Shift+j".action = move-column-to-workspace-down;
    "Super+Shift+k".action = move-column-to-workspace-up;
    "Super+Shift+l".action = move-column-right;

    # Workspace switching
    "Super+1".action = focus-workspace 1;
    "Super+2".action = focus-workspace 2;
    "Super+3".action = focus-workspace 3;
    "Super+4".action = focus-workspace 4;
    "Super+5".action = focus-workspace 5;

    # Move windows to workspace
    "Super+Shift+1".action = move-column-to-workspace 1;
    "Super+Shift+2".action = move-column-to-workspace 2;
    "Super+Shift+3".action = move-column-to-workspace 3;
    "Super+Shift+4".action = move-column-to-workspace 4;
    "Super+Shift+5".action = move-column-to-workspace 5;

    # Volume keys via Noctalia
    "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
    "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
    "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
    "Shift+XF86AudioMute".action.spawn = noctalia "volume muteInput";

    # Media keys
    "XF86AudioPlay".action.spawn = noctalia "media playPause";
    "XF86AudioNext".action.spawn = noctalia "media next";
    "XF86AudioPrev".action.spawn = noctalia "media previous";

    # Lock screen
    "Super+Shift+l".action.spawn = noctalia "lockScreen lock";
  };
}
