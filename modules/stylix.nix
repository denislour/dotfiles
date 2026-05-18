{ lib, pkgs, ... }: {
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ./wallpapers/default.jpg;
  stylix.base16Scheme = "tokyo-night-terminal-storm";
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.fonts = {
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
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
