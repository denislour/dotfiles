{ ... }: {
  imports = [ ../../system/host-base.nix ];

  networking.hostName = "my-vm-x11";

  services.xserver.enable = true;
}
