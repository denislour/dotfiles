{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    gcc
    make
    git
  ];
}
