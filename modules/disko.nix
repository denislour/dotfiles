{ inputs, ... }: {
  flake.modules.nixos.disko = {
    imports = [ inputs.disko.nixosModules.disko ];
  };

  flake.diskoConfigurations = {
    my-vm = import ./_disks/my-vm.nix;
    my-vm-x11 = import ./_disks/my-vm-x11.nix;
  };
}
