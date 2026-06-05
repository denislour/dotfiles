{ ... }: {
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.defaultSession = "xfce";

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "XFCE";
    XDG_SESSION_TYPE = "x11";
  };

  xdg.portal.config.xfce = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
