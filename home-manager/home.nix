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
    # Rust CLI tools — replacements for coreutils
    bat         # cat with syntax highlighting
    eza         # ls with icons + git status
    fd          # find replacement
    ripgrep     # grep replacement
    du-dust     # du replacement
    procs       # ps replacement
    bottom      # htop replacement
    delta       # diff with syntax highlighting
    sd          # sed replacement
  ];
}
