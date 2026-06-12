{ pkgs, ... }: {
  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";

    base16Scheme = {
      base00 = "1e1e2e";
      base01 = "181825";
      base02 = "313244";
      base03 = "45475a";
      base04 = "585b70";
      base05 = "cdd6f4";
      base06 = "f5f5f5";
      base07 = "b4befe";
      base08 = "f38ba8";
      base09 = "fab387";
      base0A = "f9e2af";
      base0B = "a6e3a1";
      base0C = "94e2d5";
      base0D = "89b4fa";
      base0E = "cba6f7";
      base0F = "f2cdcd";
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

  home-manager.users.jake = {
    stylix.targets = {
      alacritty.enable = true;
      bat.enable = true;
      firefox = {
        enable = true;
        profileNames = [ "default" ];
      };
      fzf.enable = true;
      lazygit.enable = true;
      rofi.enable = true;
      dunst.enable = true;
      starship.enable = true;
      yazi.enable = true;
      zellij.enable = true;
    };
  };
}
