{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "chadwm";

  services.xserver.desktopManager.session = [{
    name = "chadwm";
    start = ''
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
      ${pkgs.bash}/bin/bash -c 'exec ${pkgs.chadwm}/bin/chadwm'
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" ];

  hardware.graphics.extraPackages = with pkgs; [ mesa ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
