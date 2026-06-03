{ pkgs, ... }:

let
  modifier = "Mod4";
in
{
  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {};

    settings = {
      border_width = 2;
      window_gap = 6;
      split_ratio = 0.50;
      borderless_monocle = true;
      gapless_monocle = true;
      focus_follows_pointer = true;

      normal_border_color = "#4c566a";
      active_border_color = "#81a1c1";
      focused_border_color = "#5e81ac";
      presel_feedback_color = "#88c0d0";
    };

    rules = {
      "XTerm" = { state = "tiled"; };
      "ghostty" = { state = "tiled"; };
      "Rofi" = { state = "floating"; center = true; };
      "polybar" = { state = "floating"; manage = false; };
      "pavucontrol" = { state = "floating"; center = true; };
      "blueman-manager" = { state = "floating"; center = true; };
    };

    startupPrograms = [
      "${pkgs.picom}/bin/picom -b"
      "${pkgs.feh}/bin/feh --bg-scale ${../../system/wallpapers/default.jpg}"
      "${pkgs.sxhkd}/bin/sxhkd -c ${config.xdg.configHome}/sxhkd/sxhkdrc &"
    ];

    extraConfig = ''
      bspc config pointer_modifier ${modifier}
    '';
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      # Terminal
      "${modifier} + Return" = "ghostty";
      "${modifier} + Shift + Return" = "ghostty --working-directory=$HOME";

      # Rofi
      "${modifier} + d" = "rofi -show drun";
      "${modifier} + Shift + d" = "rofi -show run";
      "${modifier} + Tab" = "rofi -show window";

      # Window management
      "${modifier} + q" = "bspc node -c";
      "${modifier} + Shift + q" = "bspc node -k";
      "${modifier} + f" = "bspc node -t ~fullscreen";
      "${modifier} + t" = "bspc node -t tiled";
      "${modifier} + s" = "bspc node -t floating";
      "${modifier} + m" = "bspc node -t monocle";

      # Focus
      "${modifier} + h" = "bspc node -f west";
      "${modifier} + j" = "bspc node -f south";
      "${modifier} + k" = "bspc node -f north";
      "${modifier} + l" = "bspc node -f east";

      # Move
      "${modifier} + Shift + h" = "bspc node -p west && bspc node -s west";
      "${modifier} + Shift + j" = "bspc node -p south && bspc node -s south";
      "${modifier} + Shift + k" = "bspc node -p north && bspc node -s north";
      "${modifier} + Shift + l" = "bspc node -p east && bspc node -s east";

      # Workspaces
      "${modifier} + {1-9}" = "bspc desktop -f ^{1-9}";
      "${modifier} + Shift + {1-9}" = "bspc node -d ^{1-9}";

      # Preselect
      "${modifier} + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      "${modifier} + ctrl + space" = "bspc node -p cancel";

      # Volume
      "XF86AudioRaiseVolume" = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
      "XF86AudioLowerVolume" = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
      "XF86AudioMute" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";

      # Screenshot
      "Print" = "maim ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";
      "Shift + Print" = "maim -s ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";
    };
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
