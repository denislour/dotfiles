{ ... }: {
  imports = [
    ../../system/host-base.nix
    ../../desktop/x11/system.nix
    ../../desktop/suckless/system.nix
  ];

  networking.hostName = "my-vm-suckless";

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
}
