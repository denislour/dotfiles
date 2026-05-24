{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age
    cliphist
    curl
    gcc
    sops
    git
    gnumake
    killall
    libnotify
    unzip
    wl-clipboard
    wl-clip-persist
    xwayland-satellite
    zip
    zen-browser
    adwaita-qt
    adwaita-qt6
  ];
}
