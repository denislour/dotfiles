{ pkgs, ... }: {
  home.packages = with pkgs; [ dwm ];

  xsession.initExtra = ''
    ${pkgs.feh}/bin/feh --bg-fill '#2d353b' &
    ${pkgs.slstatus}/bin/slstatus &
    ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent &
  '';
}
