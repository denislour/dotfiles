{ ... }: {
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "xfce";

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
