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
    vim
    wl-clipboard
    wl-clip-persist
    xwayland-satellite
    zip
  ];
}
