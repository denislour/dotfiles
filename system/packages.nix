{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl unzip zip killall
    xwayland-satellite
    wl-clipboard
    libnotify
    cliphist
    wl-clip-persist
  ];
}
