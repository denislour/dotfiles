{ pkgs, ... }: {
  home.packages = with pkgs; [
    openbox dunst feh maim picom polybar redshift rofi sxhkd slop xclip xsel obconf
  ];
}
