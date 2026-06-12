{ pkgs, ... }: {
  home.packages = with pkgs; [ chadwm i3lock rofi sxhkd picom dunst ];

  xdg.configFile."wallpaper".source = ../../system/wallpapers/wallpaper.webp;

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom compositor";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.picom}/bin/picom --backend xrender";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

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

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."chadwm/autostart.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      ${pkgs.feh}/bin/feh --bg-fill "$HOME/.config/wallpaper" &
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
    '';
  };

  xdg.configFile."sxhkd/sxhkdrc".text = ''
    super + Return
      alacritty

    super + d
      rofi -show drun

    super + s
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    super + shift + s
      maim -s ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    Print
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    super + shift + q
      i3lock

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
