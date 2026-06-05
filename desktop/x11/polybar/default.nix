{ pkgs, ... }:
{
  home.packages = with pkgs; [
    polybar
    pavucontrol
    networkmanagerapplet
  ];

  xdg.configFile."polybar/config.ini".source = ./config.ini;
}
