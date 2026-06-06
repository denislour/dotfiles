{ pkgs, ... }: {
  home.packages = with pkgs; [
    brightnessctl
    feh
    lxqt.lxqt-policykit
    maim
    networkmanagerapplet
    pavucontrol
    playerctl
    redshift
    slop
    wireplumber
    xclip
    xdotool
    xsel
  ];
}
