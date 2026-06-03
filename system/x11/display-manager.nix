{ pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
  };

  services.xserver.displayManager.defaultSession = "none+bspwm";
}
