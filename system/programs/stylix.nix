{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";

    base16Scheme = {
      base00 = "2d353b";
      base01 = "343f44";
      base02 = "3d484d";
      base03 = "475258";
      base04 = "80867a";
      base05 = "d3c6aa";
      base06 = "e6e2cc";
      base07 = "f8f5e4";
      base08 = "e67e80";
      base09 = "e69875";
      base0A = "dbbc7f";
      base0B = "a7c080";
      base0C = "83c092";
      base0D = "7fbbb3";
      base0E = "d699b6";
      base0F = "f8f5e4";
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
