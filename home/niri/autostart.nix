{ pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "sh" "-c" "wl-gammarelay-rs & sleep 0.5 && busctl --user set-property rs.wl.gammarelay / rs.wl.gammarelay Temperature q 7500" ]; }
    { command = [ "wl-gammarelay-applet" "--hide-invert" "--hide-gamma" "-f" ]; }

    { command = [ "noctalia-shell" ]; }

    { command = [ "wl-clip-persist" "--clipboard" "both" ]; }

    { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
    { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }

    { command = [ "sh" "-c" "echo '' | ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --unlock" ]; }
  ];
}
