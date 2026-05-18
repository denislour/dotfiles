{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cliphist
    curl
    gcc
    git
    gnumake
    killall
    libnotify
    unzip
    vim
    wl-clipboard
    wl-clip-persist
    xwayland-satellite
    zip
  ];
}
