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

  home.packages = with pkgs; [
    fastfetch
    bat eza fd ripgrep dust procs bottom delta sd
    just
  ];

  programs.home-manager.enable = true;
}
