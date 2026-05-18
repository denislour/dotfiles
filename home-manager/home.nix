{ lib, pkgs, ... }: {
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  imports = [
    ./programs/git.nix
    ./programs/foot.nix
    ./programs/yazi.nix
    ./programs/zoxide.nix
    ./programs/bash.nix
    ./programs/waybar.nix
    ./services/hyprland.nix
  ];

  home.packages = with pkgs; [
    fastfetch
    bat eza fd ripgrep dust procs bottom delta sd
  ];
}
