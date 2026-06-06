{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "none+openbox";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.displayManager.session = [{
    name = "openbox";
    manage = "window";
    start = ''
      exec ${pkgs.openbox}/bin/openbox
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
