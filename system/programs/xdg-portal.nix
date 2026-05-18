{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
  ];
}
