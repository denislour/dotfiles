{ pkgs, ... }: {
  home.packages = with pkgs; [
    feh
    maim
    networkmanagerapplet
  ];
}
