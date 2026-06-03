{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";

    base16Scheme = {
      base00 = "1e1e2e";
      base01 = "2e2e3e";
      base02 = "363647";
      base03 = "585b70";
      base04 = "8c8fa1";
      base05 = "c6d0f5";
      base06 = "e6e9f0";
      base07 = "f2f3f5";
      base08 = "f28fad";
      base09 = "f8bd96";
      base0A = "f9e2af";
      base0B = "a6e3a1";
      base0C = "89dceb";
      base0D = "8caaee";
      base0E = "caa7f0";
      base0F = "f5c2e7";
    };

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
}
