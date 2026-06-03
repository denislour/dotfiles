{ pkgs, ... }:

{
  environment.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Banana";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];
}
