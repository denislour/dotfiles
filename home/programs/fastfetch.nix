{ config, lib, pkgs, ... }: let
  dogeLogo = ./doge.txt;
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "file-raw";
        source = "${dogeLogo}";
        padding = { left = 2; };
        color = { "1" = "yellow"; };
      };
      display = {
        separator = " → ";
        color = "blue";
      };
      modules = "default";
    };
  };
}
