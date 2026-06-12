{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "chadwm";

  services.xserver.displayManager.lightdm.enable = true;

  services.xserver.desktopManager.session = [{
    name = "chadwm";
    start = ''
      ${pkgs.bash}/bin/bash -c 'exec ${pkgs.chadwm}/bin/chadwm'
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
