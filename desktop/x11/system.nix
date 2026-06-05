{ pkgs, ... }: {
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.defaultSession = "none+bspwm";

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "bspwm";
    XDG_SESSION_TYPE = "x11";
  };

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
