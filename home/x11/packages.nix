{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    dunst
    feh
    maim
    openbox
    picom
    polybar
    redshift
    rofi
    slop
    xclip
    xsel
  ];
}
