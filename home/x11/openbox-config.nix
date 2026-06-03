{ pkgs, ... }:

{
  xsession.windowManager.openbox = {
    enable = true;

    settings = {
      menu.showIcons = true;
    };

    startupPrograms = [
      "${pkgs.picom}/bin/picom -b"
      "${pkgs.feh}/bin/feh --bg-scale ${../../system/wallpapers/default.jpg}"
    ];
  };
}
