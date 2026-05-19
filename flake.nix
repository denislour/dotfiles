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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen = {
      url = "github:zstg/zen-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, stylix, niri, noctalia, sops-nix, zen, ... }@inputs:
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
        specialArgs = {
          inherit self inputs;
          wallpaper = ./system/wallpapers/default.jpg;
        };
        modules = [
          stylix.nixosModules.stylix
          disko.nixosModules.disko
          inputs.sops-nix.nixosModules.sops
          ./hosts/my-vm/disk-config.nix
          ./hosts/my-vm/configuration.nix
          ./system/packages.nix
          ./system/environment.nix
          ./system/services/greetd.nix
          ./system/services/sops.nix
          ./system/common.nix
          ./system/programs/stylix.nix
          ./system/programs/xdg-portal.nix
          ./system/services/ssh.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.jake = import ./hosts/my-vm/home.nix;
          }
        ];
      };
    };
}
