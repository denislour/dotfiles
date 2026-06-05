{ pkgs, ... }: {
  home.packages = with pkgs; [
    maim slop xclip xsel redshift
  ];
}
