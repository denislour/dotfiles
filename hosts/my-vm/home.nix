{ config, pkgs, ... }:

{
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  imports = [
    ../../home/niri
    ../../home/programs/astronvim
    ../../home/programs/atuin.nix
    ../../home/programs/bat.nix
    ../../home/programs/bottom.nix
    ../../home/programs/starship.nix
    ../../home/programs/delta.nix
    ../../home/programs/eza.nix
    ../../home/programs/fastfetch.nix
    ../../home/programs/fd.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/librewolf.nix
    ../../home/programs/git.nix
    ../../home/programs/pi
    ../../home/programs/ripgrep.nix
    ../../home/programs/zed-editor
    ../../home/programs/yazi.nix
    ../../home/programs/zoxide.nix
    ../../home/programs/zsh.nix
  ];

  home.packages = import ./packages.nix { inherit pkgs; };

  programs.home-manager.enable = true;


}
