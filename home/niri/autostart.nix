{ pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "sh" "-c" "wl-gammarelay-rs & sleep 0.5 && gdbus call --session --dest rs.wl.gammarelay --object-path / --method rs.wl.gammarelay.UpdateGamma '(ddd)' 0.85 1.0 1.0" ]; }

    { command = [ "noctalia-shell" ]; }

    { command = [ "wl-clip-persist" "--clipboard" "both" ]; }

    { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
    { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }

    { command = [ "sh" "-c" "echo '' | ${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --unlock" ]; }
  ];
}
