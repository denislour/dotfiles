{ pkgs, config, ... }:

let
  wallpaperPath = "/home/${config.home.username}/Pictures/Wallpapers/default.jpg";
in
{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "noctalia-shell" ]; }
    { command = [ "${pkgs.swaybg}/bin/swaybg" "-i" wallpaperPath "-m" "fill" ]; }
  ];
}
