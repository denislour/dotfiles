{ pkgs, ... }:

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
    ../../home/programs/fastfetch
    ../../home/programs/fd.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/git.nix
    ../../home/programs/lazygit.nix
    ../../home/programs/librewolf
    ../../home/programs/pi
    ../../home/programs/ripgrep.nix
    ../../home/programs/zed-editor
    ../../home/programs/yazi.nix
    ../../home/programs/zoxide.nix
    ../../home/programs/zsh.nix
    ../../home/packages.nix
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
