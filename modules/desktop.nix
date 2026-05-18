{ lib, pkgs, ... }: {

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

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
    foot
    waybar
    swaybg
    rofi
    wl-clipboard
    grim
    slurp
    swappy
    thunar
    polkit_gnome
  ];
}
