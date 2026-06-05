{ pkgs, ... }: {
  home.packages = with pkgs; [
    openbox dunst feh maim picom polybar redshift rofi slop xclip xsel obconf
  ];
}
