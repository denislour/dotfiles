{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget curl unzip zip killall
    xwayland-satellite
    wl-clipboard
    libnotify
    swaybg
  ];
}
