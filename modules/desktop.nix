{ lib, pkgs, ... }:

{
  programs.niri.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    waybar
    rofi
    awww
    wl-clipboard
    grim
    slurp
    swappy
    thunar
  ];
}
