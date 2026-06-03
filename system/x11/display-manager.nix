{ pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
  };

  services.xserver.displayManager.defaultSession = "i3";

  services.xserver.displayManager.session = [{
    manage = "window";
    name = "i3";
    start = ''
      ${pkgs.i3}/bin/i3
    '';
  }];
}
