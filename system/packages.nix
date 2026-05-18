{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl unzip zip killall
    xwayland-satellite
    wl-clipboard
    cliphist
    wl-clip-persist
  ];
}
