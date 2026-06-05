{ ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
  };
  services.displayManager.defaultSession = "none+openbox";
  services.xserver.windowManager.openbox.enable = true;

  environment.pathsToLink = [ "/share/xsessions" "/share/themes" ];

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "openbox";
    XDG_SESSION_TYPE = "x11";
  };

  xdg.portal.config.openbox = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
