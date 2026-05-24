{ pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "wlsunset" "-t" "6500" "-T" "6500" ]; }

    { command = [ "noctalia-shell" ]; }

    { command = [ "wl-clip-persist" "--clipboard" "both" ]; }

    { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
    { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }

    { command = [ "sh" "-c" "echo '' | ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --unlock" ]; }
  ];
}
