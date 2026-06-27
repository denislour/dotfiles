{ pkgs, ... }:

{
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  imports = [
    ../../desktop/wayland/home.nix
    ../../home/programs/astronvim
    ../../home/programs/atuin.nix
    ../../home/programs/bat.nix
    ../../home/programs/bottom.nix
    ../../home/programs/starship.nix
    ../../home/programs/delta.nix
    ../../home/programs/eza.nix
    ../../home/programs/fastfetch
    ../../home/programs/fd.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/git.nix
    ../../home/programs/lazygit.nix
    ../../home/programs/brave.nix
    ../../home/programs/pi
    #../../home/programs/zed-editor  # enable when needed
    ../../home/programs/ripgrep.nix
    ../../home/programs/yazi.nix
    ../../home/programs/zoxide.nix
    ../../home/programs/zsh.nix
    ../../home/programs/go.nix
    ../../home/packages.nix
    ../../home/programs/liger.nix
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  programs.home-manager.enable = true;
}
