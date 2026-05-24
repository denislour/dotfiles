{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age
    curl
    gcc
    sops
    git
    gnumake
    killall
    libnotify
    unzip
    xwayland-satellite
    zip
    adwaita-qt
    adwaita-qt6
  ];
}
