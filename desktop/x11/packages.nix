{ pkgs, ... }:

let
  kde = pkgs.kdePackages;
in
{
  home.packages = with pkgs; [
    xclip xsel
  ] ++ (with kde; [
    kate
    dolphin
    gwenview
  ]);
}
