{ ... }: {
  flake.modules.nixos.vmware = {
    virtualisation.vmware.guest.enable = true;
  };
}
