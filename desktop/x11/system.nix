{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "none+bspwm";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.displayManager.session = [{
    name = "bspwm";
    manage = "window";
    start = ''
      exec ${pkgs.bspwm}/bin/bspwm
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
