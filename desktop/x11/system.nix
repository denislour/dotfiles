{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "openbox";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.desktopManager.session = [{
    name = "openbox";
    start = ''
      source /home/jake/.config/openbox/autostart
      exec ${pkgs.openbox}/bin/openbox
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
