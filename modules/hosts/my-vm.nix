{ config, ... }:

let
  inherit (config.flake.modules) nixos homeManager;
in
{
  configurations.nixos.my-vm.module = {
    imports = [
      nixos.base
      nixos.disko
      nixos.common
      nixos.vmware
      nixos.stylix
      nixos.secrets
      nixos.ssh
      nixos.wayland
      nixos.home-manager
      ../_disks/my-vm.nix
    ];

    nixpkgs.hostPlatform = "x86_64-linux";
    networking.hostName = "my-vm";
    boot.loader.efi.canTouchEfiVariables = false;
    system.stateVersion = "25.05";

    home-manager.users.jake = { pkgs, lib, ... }: {
      home.username = lib.mkForce "jake";
      home.homeDirectory = lib.mkForce "/home/jake";
      home.stateVersion = "25.05";

      imports = [
        homeManager.niri
        homeManager.noctalia
        homeManager.ghostty
        homeManager.zsh
        homeManager.programs
        homeManager.packages
        homeManager.astronvim
        homeManager.pi
        homeManager.brave
        homeManager.fastfetch
        homeManager.liger
      ];

      gtk = {
        enable = true;
        iconTheme = {
          name = "Papirus";
          package = pkgs.papirus-icon-theme;
        };
      };

      programs.home-manager.enable = true;
    };
  };
}
