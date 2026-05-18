{ config, pkgs, ... }:

{
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  imports = [
    ../../home/niri
    ../../home/programs/zsh.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/git.nix
    ../../home/programs/yazi.nix
    ../../home/programs/zoxide.nix
  ];

  home.packages = import ./packages.nix { inherit pkgs; };

  programs.home-manager.enable = true;
}
