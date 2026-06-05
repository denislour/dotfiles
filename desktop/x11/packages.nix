{ pkgs, ... }: {
  home.packages = with pkgs; [
    xclip xsel
    kate
    dolphin
    gwenview
  ];
}
