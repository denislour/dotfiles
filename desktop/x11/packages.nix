{ pkgs, ... }: {
  home.packages = with pkgs; [
    xclip xsel
    plasma5Packages.kate
    plasma5Packages.dolphin
    plasma5Packages.gwenview
  ];
}
