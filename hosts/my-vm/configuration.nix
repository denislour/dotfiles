{ ... }: {
  imports = [ ../../system/host-base.nix ];

  networking.hostName = "my-vm";
}
