{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";

    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 12;
        terminal = 10;
      };
    };

    targets = {
      gtk.enable = true;
      qt.enable = true;
      plymouth.enable = false;
    };
    opacity = {
      terminal = 0.95;
      popups = 0.95;
    };
  };

  programs.dconf.enable = true;
  qt.enable = true;
}
