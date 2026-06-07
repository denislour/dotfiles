{ pkgs, ... }:

{
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  imports = [
    ../../desktop/x11/home.nix
    ../../home/programs/astronvim
    ../../home/programs/atuin.nix
    ../../home/programs/bat.nix
    ../../home/programs/bottom.nix
    ../../home/programs/starship.nix
    ../../home/programs/delta.nix
    ../../home/programs/eza.nix
    ../../home/programs/fastfetch
    ../../home/programs/fd.nix
    ../../home/programs/alacritty.nix
    ../../home/programs/zellij.nix
    ../../home/programs/git.nix
    ../../home/programs/lazygit.nix
    ../../home/programs/librewolf.nix
    ../../home/programs/pi
    ../../home/programs/polycat
    ../../home/programs/polybar.nix
    ../../home/programs/rofi.nix
    # ../../home/programs/zed-editor  # enable when needed
    ../../home/programs/ripgrep.nix
    ../../home/programs/yazi.nix
    ../../home/programs/zoxide.nix
    ../../home/programs/zsh.nix
    ../../home/packages.nix
    ../../home/programs/liger.nix
    ../../home/programs/mpd.nix
  ];

  stylix.targets = {
    alacritty.enable = true;
    bat.enable = true;
    fzf.enable = true;
    lazygit.enable = true;
    rofi.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zellij.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  programs.home-manager.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };

  xdg.configFile."mimeapps.list".force = true;
  xdg.dataFile."applications/mimeapps.list".force = true;
}
