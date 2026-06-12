{ lib, ... }:
{
  imports = [ ../../system/host-base.nix ];

  networking.hostName = "my-vm-x11";

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "jake";
  };
}
