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

    # native build deps (cargo install, worker-build, openssl-sys)
    pkg-config
    openssl
  ];
}
