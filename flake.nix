{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      diskoConfigurations = {
        my-vm = import ./hosts/my-vm/disk-config.nix;
      };

      nixosConfigurations.my-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          disko.nixosModules.disko
          ./hosts/my-vm/disk-config.nix
          ./hosts/my-vm/configuration.nix
          ./modules/common.nix
          ./modules/desktop.nix
          ./modules/development.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jake = import ./home-manager/home.nix;
          }
        ];
      };
    };
}
