{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    bspwm
    dunst
    feh
    maim
    picom
    polybar
    redshift
    rofi
    sxhkd
    slop
    xclip
    xsel
  ];
}
