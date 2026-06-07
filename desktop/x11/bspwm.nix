{ pkgs, ... }: {
  home.packages = with pkgs; [ bspwm rofi sxhkd ];

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

    polybar main &
    picom &
    dunst &
    nm-applet &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    feh --bg-fill $HOME/.config/wallpaper &

    sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
  '';
  };

  xdg.configFile."polybar/config.ini".text = ''
    [colors]
    bg = #232136
    fg = #e0def4
    pink = #d3869b
    purple = #c3a5e6
    blue = #34738e
    cyan = #eabbb9
    yellow = #f1ca93
    red = #ea6f91
    green = #9bced7

    [bar/main]
    monitor = ''${env:MONITOR:}
    bottom = true
    width = 95%
    height = 24
    offset-x = 2.5%
    offset-y = 2
    radius-bottom = 4
    background = ''${colors.bg}
    foreground = ''${colors.fg}
    line-size = 2
    line-color = ''${colors.blue}
    padding-left = 12
    padding-right = 12
    module-margin-left = 0
    module-margin-right = 0
    font-0 = "JetBrainsMono Nerd Font:size=10"
    modules-left = bspwm
    modules-right = cpu memory pulseaudio date tray
    separator = |
    enable-ipc = true

    [module/bspwm]
    type = internal/bspwm
    pin-workspaces = true
    label-active = %name%
    label-active-foreground = ''${colors.bg}
    label-active-background = ''${colors.purple}
    label-active-padding = 2
    label-occupied = %name%
    label-occupied-foreground = ''${colors.fg}
    label-urgent = %name%
    label-urgent-foreground = ''${colors.red}
    label-empty = %name%
    label-empty-foreground = ''${colors.fg}
    label-empty-padding = 2

    [module/cpu]
    type = internal/cpu
    interval = 1
    format = <label>
    format-prefix = " "
    format-prefix-foreground = ''${colors.bg}
    format-prefix-background = ''${colors.yellow}
    label = %percentage%%
    label-foreground = ''${colors.bg}
    label-background = ''${colors.yellow}
    label-padding-right = 2

    [module/memory]
    type = internal/memory
    interval = 3
    format = <label>
    format-prefix = " "
    format-prefix-foreground = ''${colors.bg}
    format-prefix-background = ''${colors.purple}
    label = %percentage_used%%
    label-foreground = ''${colors.bg}
    label-background = ''${colors.purple}
    label-padding-right = 2

    [module/pulseaudio]
    type = internal/pulseaudio
    interval = 5
    format-volume = <label-volume>
    format-volume-prefix = " "
    format-volume-prefix-foreground = ''${colors.bg}
    format-volume-prefix-background = ''${colors.blue}
    label-volume = %percentage%%
    label-volume-foreground = ''${colors.bg}
    label-volume-background = ''${colors.blue}
    format-muted = <label-muted>
    label-muted = " mute"
    label-muted-foreground = ''${colors.fg}

    [module/date]
    type = internal/date
    interval = 30
    date = %a %d %b %H:%M
    format = <label>
    format-prefix = " "
    format-prefix-foreground = ''${colors.bg}
    format-prefix-background = ''${colors.green}
    label = %date%
    label-foreground = ''${colors.bg}
    label-background = ''${colors.green}
    label-padding-right = 2

    [module/tray]
    type = internal/tray
    spacing = 8
  '';

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
