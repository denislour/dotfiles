{ ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
  };
  services.displayManager.defaultSession = "none+bspwm";
  services.xserver.windowManager.bspwm.enable = true;

  environment.pathsToLink = [ "/share/xsessions" ];

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "bspwm";
    XDG_SESSION_TYPE = "x11";
  };

  xdg.portal.config.bspwm = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
