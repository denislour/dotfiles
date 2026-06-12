{ pkgs, lib, ... }:

{
  services.displayManager.defaultSession = lib.mkDefault "chadwm";

  services.xserver.displayManager.lightdm.enable = true;

  services.xserver.desktopManager.session = [{
    name = "chadwm";
    start = ''
      sleep 0.5 && ${pkgs.feh}/bin/feh --bg-fill /home/jake/.config/wallpaper &
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
      ${pkgs.bash}/bin/bash -c 'exec ${pkgs.chadwm}/bin/chadwm'
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
