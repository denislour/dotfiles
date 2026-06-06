{ pkgs, ... }: {
  home.packages = with pkgs; [ bspwm sxhkd ];

  xdg.configFile."bspwm/bspwmrc".text = ''
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

    polybar main &
    picom --experimental-backends &
    dunst &
    nm-applet &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    feh --bg-fill /run/current-system/sw/share/backgrounds/nixos/nix-wallpaper-nineish-dark-gray.png &

    sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
  '';

  xdg.configFile."sxhkd/sxhkdrc".text = ''
    alt + Return
      alacritty

    alt + space
      rofi -show drun

    alt + q
      bspc node -c

    alt + f
      bspc node -t ~fullscreen

    alt + t
      bspc node -t ~floating

    alt + s
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    alt + shift + s
      maim -s ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    Print
      maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png

    alt + {h,j,k,l}
      bspc node -f {west,south,north,east}

    alt + shift + {h,j,k,l}
      bspc node -m {west,south,north,east}

    alt + {1-9}
      bspc desktop -f ^{1-9}

    alt + shift + {1-9}
      bspc node -d ^{1-9}

    alt + m
      bspc node -d ^9

    alt + shift + m
      bspc desktop -f ^9

    alt + shift + q
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
