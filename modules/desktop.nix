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

  # Polkit authentication agent (graphical)
  systemd.user.services.polkit-gnome = {
    description = "PolicyKit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = "1s";
      TimeoutStopSec = "10s";
    };
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
    polkit_gnome
  ];
}
