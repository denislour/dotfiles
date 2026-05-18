{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cliphist
    curl
    killall
    libnotify
    unzip
    wl-clipboard
    wl-clip-persist
    xwayland-satellite
    zip
  ];
}
