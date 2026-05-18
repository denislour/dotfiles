{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
  ];
}
