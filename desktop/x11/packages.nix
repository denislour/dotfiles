{ pkgs, ... }: {
  home.packages = with pkgs; [
    openbox dunst feh maim picom tint2 redshift rofi slop xclip xsel obconf
  ];
}
