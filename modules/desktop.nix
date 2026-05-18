{ lib, pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
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
    wireplumber.enable = true;
  };

  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    # terminal (foot = CPU render, no GPU needed)
    foot
    # hypr ecosystem
    hyprpaper
    hyprlock
    hypridle
    xdg-desktop-portal-hyprland
    # bar & launcher
    waybar
    rofi
    # notifications
    dunst
    # clipboard
    cliphist
    wl-clipboard
    # screenshot
    grim
    slurp
    swappy
    # utils
    yazi
    networkmanagerapplet
    polkit_gnome
    # audio
    pavucontrol
    pamixer
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    enable = true;
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
