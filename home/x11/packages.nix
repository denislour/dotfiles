{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    dunst
    feh
    i3
    maim
    picom
    polybar
    redshift
    rofi
    slop
    xclip
    xsel
  ];
}
