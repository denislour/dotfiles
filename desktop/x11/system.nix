{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "bspwm";

  services.xserver.displayManager.lightdm.enable = true;

  services.xserver.desktopManager.session = [{
    name = "bspwm";
    start = ''
      ${pkgs.bash}/bin/bash -c 'exec ${pkgs.bspwm}/bin/bspwm'
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
