{ pkgs, ... }: {
  home.packages = with pkgs; [
    brightnessctl
    feh
    lxqt.lxqt-policykit
    maim
    networkmanagerapplet
    pavucontrol
    redshift
    slop
    wireplumber
    xclip
    xsel
  ];
}
