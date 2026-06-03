{ pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
  };

  services.xserver.displayManager.defaultSession = "none+openbox";

  environment.pathsToLink = [ "/share/xsessions" ];
}
