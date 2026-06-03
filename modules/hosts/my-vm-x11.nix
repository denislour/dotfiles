{ config, ... }:

let
  inherit (config.flake.modules) nixos homeManager;
in
{
  configurations.nixos.my-vm-x11.module = {
    imports = [
      nixos.base
      nixos.disko
      nixos.common
      nixos.stylix
      nixos.secrets
      nixos.ssh
      nixos.x11
      nixos.home-manager
      ../_disks/my-vm-x11.nix
    ];

    nixpkgs.hostPlatform = "x86_64-linux";
    networking.hostName = "my-vm-x11";
    boot.loader.efi.canTouchEfiVariables = false;
    system.stateVersion = "25.05";

    home-manager.users.jake = { pkgs, lib, ... }: {
      home.username = lib.mkForce "jake";
      home.homeDirectory = lib.mkForce "/home/jake";
      home.stateVersion = "25.05";

      imports = [
        homeManager.bspwm
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
