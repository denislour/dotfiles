{ inputs, ... }:

let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  flake.modules.homeManager.bspwm = { pkgs, ... }: {
    home.packages = with pkgs; [ dunst feh maim picom polybar redshift rofi sxhkd slop xclip xsel ];

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
        "${pkgs.feh}/bin/feh --bg-scale ${../../wallpapers/default.jpg}"
        "${pkgs.sxhkd}/bin/sxhkd -c ${./sxhkdrc}"
      ];

      extraConfig = ''
        bspc config pointer_modifier alt
      '';
    };

    systemd.user.services.redshift = {
      Unit = {
        Description = "Redshift color temperature adjustment";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.redshift}/bin/redshift -t 5500:4500 -l 10.8:106.7";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
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
  };
}
