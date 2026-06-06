{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "bspwm";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.desktopManager.session = [
    {
      name = "openbox";
      start = ''
        source /home/jake/.config/openbox/autostart
        exec ${pkgs.openbox}/bin/openbox
      '';
    }
    {
      name = "bspwm";
      start = ''
        source /home/jake/.config/bspwm/bspwmrc
        exec ${pkgs.bspwm}/bin/bspwm
      '';
    }
  ];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
