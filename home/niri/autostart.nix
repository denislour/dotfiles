{ pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "wlsunset" "-t" "7500" "-T" "7500" ]; }

    { command = [ "noctalia-shell" ]; }

    { command = [ "wl-clip-persist" "--clipboard" "both" ]; }

    { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
    { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }

    { command = [ "sh" "-c" "echo '' | ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --unlock" ]; }
  ];
}
