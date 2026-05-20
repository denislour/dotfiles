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

    # Explicitly enable targets (autoEnable is off)
    targets = {
      gtk.enable = true;
      qt.enable = true;
      plymouth.enable = false;
    };

    # Terminal & window opacity
    opacity = {
      terminal = 0.95;
      popups = 0.95;
    };
  };

  # Required for GTK theming (dconf database)
  programs.dconf.enable = true;

  # Qt integration: Qt apps follow the same GTK theme from Stylix
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
