{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    gcc
    gnumake
    git
  ];
}
