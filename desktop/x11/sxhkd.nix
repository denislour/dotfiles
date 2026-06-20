{ pkgs, ... }: {
  home.packages = with pkgs; [ sxhkd ];

  systemd.user.services.sxhkd = {
    Unit = {
      Description = "SXHKD hotkey daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."sxhkd/sxhkdrc".text = ''
    mod1 + Return
      alacritty

    mod1 + shift + y
      alacritty -e rainfrog

    mod1 + space
      rofi -show drun

    mod1 + s
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    mod1 + shift + s
      maim -s ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    Print
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    mod1 + shift + q
      slock

    XF86AudioRaiseVolume
      pactl set-sink-volume @DEFAULT_SINK@ +5%

    XF86AudioLowerVolume
      pactl set-sink-volume @DEFAULT_SINK@ -5%

    XF86AudioMute
      pactl set-sink-mute @DEFAULT_SINK@ toggle

    XF86AudioPlay
      playerctl play-pause

    XF86AudioNext
      playerctl next

    XF86AudioPrev
      playerctl previous
  '';
}
