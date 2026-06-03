{ pkgs, ... }:

let
  modifier = "alt";
in
{
  xsession.windowManager.bspwm = {
    enable = true;

    settings = {
      border_width = 2;
      window_gap = 6;
      split_ratio = 0.50;
      borderless_monocle = true;
      gapless_monocle = true;
    };

    rules = {
      "Rofi" = { state = "floating"; center = true; };
      "ghostty" = { state = "tiled"; };
    };

    startupPrograms = [
      "${pkgs.picom}/bin/picom -b"
      "${pkgs.feh}/bin/feh --bg-scale ${../../system/wallpapers/default.jpg}"
      "${pkgs.sxhkd}/bin/sxhkd -c ${../../home/x11/sxhkdrc}"
    ];

    extraConfig = ''
      bspc config pointer_modifier ${modifier}
    '';
  };

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
