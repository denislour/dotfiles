{ ... }: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "KDE";
    XDG_SESSION_TYPE = "x11";
  };

  xdg.portal.config.plasma = {
    default = [ "kde" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
  };
}
