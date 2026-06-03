{ pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
    autoLogin = {
      enable = true;
      user = "jake";
    };
  };

  services.xserver.displayManager.defaultSession = "i3";
}
