{ pkgs, ... }:
let
  bspwmrc = pkgs.writeShellScript "bspwmrc" ''
    ${pkgs.sxhkd}/bin/sxhkd -c ~/.config/sxhkd/sxhkdrc &
    ${pkgs.picom}/bin/picom -b
    ${pkgs.dunst}/bin/dunst &
    ${pkgs.feh}/bin/feh --bg-fill '#2d353b'
    ${pkgs.polybar}/bin/polybar main &
    ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent &
    bspc monitor -d 1 2 3 4
    bspc config border_width 0
    bspc config window_gap 4
  '';
in
{
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.defaultSession = "bspwm";
  services.displayManager.session = [{
    manage = "window";
    name = "bspwm";
    start = ''
      ${bspwmrc} &
      waitPID=$!
      wait "$waitPID"
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "bspwm";
    XDG_SESSION_TYPE = "x11";
  };

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}
