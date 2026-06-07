{
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
    width = 100%
    height = 24
    radius = 0
    radius-bottom = 0
    background = ''${colors.bg}
    foreground = ''${colors.fg}
    line-size = 2
    line-color = ''${colors.blue}
    padding-left = 2
    padding-right = 2
    module-margin-left = 0
    module-margin-right = 0
    font-0 = "JetBrainsMono Nerd Font:size=10"
    modules-left = bspwm
    modules-right = cpu memory pulseaudio date tray
    separator = |
    enable-ipc = true

    [module/bspwm]
    type = internal/bspwm
    enable-click = true
    enable-scroll = true
    reverse-scroll = true
    pin-workspaces = true
    occupied-scroll = false
    ws-icon-0 = 1;
    ws-icon-1 = 2;
    ws-icon-2 = 3;
    ws-icon-3 = 4;
    ws-icon-4 = 5;
    ws-icon-5 = 6;
    ws-icon-6 = 7;
    ws-icon-7 = 8;ﬦ
    ws-icon-8 = 9;煮
    label-active = %icon%
    label-active-foreground = ''${colors.bg}
    label-active-background = ''${colors.purple}
    label-active-padding = 1
    label-occupied = %icon%
    label-occupied-foreground = ''${colors.fg}
    label-urgent = %icon%
    label-urgent-foreground = ''${colors.red}
    label-empty = %icon%
    label-empty-foreground = ''${colors.fg}
    label-empty-padding = 1
    label-separator = " "

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
}
