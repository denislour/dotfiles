{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

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
    zip
    adwaita-qt
    adwaita-qt6
    pkg-config
    openssl
    docker-compose
  ];
}
