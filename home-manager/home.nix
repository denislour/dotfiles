{ pkgs, ... }:

{
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    fastfetch
    swaybg
    polkit-gnome
  ];

  programs.git = {
    enable = true;
    userName = "Lektor";
    userEmail = "Lektor@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      alias ll='ls -la'
      alias la='ls -A'
      alias v='vim'
      alias g='git'
    '';
  };

  xdg.configFile."niri/config.kdl".text = ''
    // Niri config - generated from dotfiles
    input {
        keyboard {
            xkb {
                layout "us"
            }
            numlock
        }
        touchpad {
            tap
            natural-scroll
        }
    }

    layout {
        gaps 8 8 8 8
        border {
            active-color "#33ccff"
            inactive-color "#595959"
            width 2
        }
    }

    spawn-at-startup "waybar"
    spawn-at-startup "nm-applet"
    spawn-at-startup "swaybg" "-i" "/run/current-system/sw/share/backgrounds/nixos/nix-wallpaper.png" "-m" "fill"

    binds {
        // Terminal
        Super+Q { spawn "kitty"; }
        // Launcher
        Super+R { spawn "rofi -show drun"; }
        // Close window
        Super+W { close-window; }
        // Fullscreen
        Super+F { toggle-window-flags "fullscreen"; }
        // Quit niri
        Super+Shift+E { quit; }

        // Focus
        Super+H { focus-left; }
        Super+J { focus-down; }
        Super+K { focus-up; }
        Super+L { focus-right; }

        // Move windows
        Super+Shift+H { move-column-left; }
        Super+Shift+J { move-window-down; }
        Super+Shift+K { move-window-up; }
        Super+Shift+L { move-column-right; }

        // Workspaces
        Super+1 { focus-workspace 1; }
        Super+2 { focus-workspace 2; }
        Super+3 { focus-workspace 3; }
        Super+4 { focus-workspace 4; }
        Super+5 { focus-workspace 5; }

        Super+Shift+1 { move-window-or-workspace-to-workspace 1; }
        Super+Shift+2 { move-window-or-workspace-to-workspace 2; }
        Super+Shift+3 { move-window-or-workspace-to-workspace 3; }
        Super+Shift+4 { move-window-or-workspace-to-workspace 4; }
        Super+Shift+5 { move-window-or-workspace-to-workspace 5; }

        // Screenshot
        Print { spawn "grimblast" "copy" "area"; }

        // Audio
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    }
  '';
}
