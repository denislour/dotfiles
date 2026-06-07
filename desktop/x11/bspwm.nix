{ pkgs, ... }: {
  home.packages = with pkgs; [ bspwm i3lock rofi sxhkd ];

  xdg.configFile."wallpaper".source = ../../system/wallpapers/wallpaper.webp;

  xdg.configFile."bspwm/bspwmrc" = {
    executable = true;
    text = ''
    #!/usr/bin/env bash
    bspc monitor -d 1 2 3 4 5 6 7 8 9
    bspc config border_width 2
    bspc config window_gap 6
    bspc config split_ratio 0.50
    bspc config focus_follows_pointer true
    bspc config pointer_follows_monitor true
    bspc config pointer_follows_focus true
    bspc config focused_border_color "#cba6f7"
    bspc config normal_border_color "#313244"
    bspc config active_border_color "#585b70"
    bspc config presel_feedback_color "#585b70"

    killall -q polybar
    while pgrep -u \$UID -x polybar >/dev/null; do sleep 1; done
    polybar main &
    picom &
    dunst &
    nm-applet &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    feh --bg-fill $HOME/.config/wallpaper &

    sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
  '';
  };


  xdg.configFile."sxhkd/sxhkdrc".text = ''
    mod1 + Return
      alacritty

    mod1 + Tab
      bspc node -f next

    mod1 + space
      rofi -show drun

    mod1 + q
      bspc node -c

    mod1 + f
      if [ -z "$(bspc query -N -n focused.fullscreen)" ]; then \
        bspc node focused -t fullscreen; \
      else \
        bspc node focused -t tiled; \
      fi

    mod1 + t
      if [ -z "$(bspc query -N -n focused.floating)" ]; then \
        bspc node focused -t floating; \
      else \
        bspc node focused -t tiled; \
      fi

    mod1 + s
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    mod1 + shift + s
      maim -s ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    Print
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    mod1 + {h,j,k,l}
      bspc node -f {west,south,north,east}

    mod1 + shift + {h,j,k,l}
      bspc node -m {west,south,north,east}

    mod1 + {1-9}
      bspc desktop -f {1-9}

    mod1 + shift + {1-9}
      bspc node -d {1-9}

    mod1 + m
      bspc node -d 9

    mod1 + shift + m
      bspc desktop -f 9

    mod1 + shift + q
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
