{ pkgs, ... }:

{
  home.packages = with pkgs; [ polybar ];

  xdg.configFile."polybar/config.ini".text = ''
    [color]
    bg = #232136
    bg-alt = #00232136
    fg = #e0def4

    trans = #00000000
    white = #FFFFFF
    black = #000000

    red = #ea6f91
    pink = #d3869b
    purple = #c3a5e6
    blue = #34738e
    cyan = #eabbb9
    teal = #00B19F
    green = #9bced7
    lime = #8ec07c
    yellow = #f1ca93
    amber = #fac33b
    orange = #f08641
    brown = #AC8476
    grey = #384148
    indigo = #6C77BB
    blue-gray = #6D8895

    [bar/main]
    monitor = ''${env:MONITOR:}
    monitor-strict = false
    override-redirect = false

    bottom = true
    fixed-center = false

    width = 95%
    height = 34

    offset-x = 2.5%
    offset-y = 4

    background = ''${color.bg}
    foreground = ''${color.fg}

    line-size = 3
    line-color = ''${color.blue}

    border-size = 14
    border-color = ''${color.bg}

    padding-left = 6
    padding-right = 6

    module-margin-left = 0
    module-margin-right = 0

    font-0 = "JetBrainsMono Nerd Font:style=Bold:size=13;2"
    font-1 = "JetBrainsMono Nerd Font:style=Regular:size=18;3"

    modules-left = launcher sep term folder browser sep title
    modules-center =
    modules-right = weather sep usercard sep mplayer sep workspace bgd filesystem brd cpu_bar byd memory_bar bpd network bod date bid sep tray sep power

    separator =
    dim-value = 1.0

    wm-restack = bspwm
    enable-ipc = true

    cursor-click = pointer
    cursor-scroll =

    [settings]
    screenchange-reload = false
    compositing-background = source
    compositing-foreground = over
    compositing-overline = over
    compositing-underline = over
    compositing-border = over
    pseudo-transparency = false

    ; ───────────────────────── DIAMOND SEPARATORS ─────────────────────────

    [module/bgd]
    type = custom/text
    label = ""
    label-foreground = ''${color.bg}
    label-background = ''${color.green}

    [module/brd]
    type = custom/text
    label = ""
    label-foreground = ''${color.bg}
    label-background = ''${color.red}

    [module/byd]
    type = custom/text
    label = ""
    label-foreground = ''${color.bg}
    label-background = ''${color.yellow}

    [module/bpd]
    type = custom/text
    label = ""
    label-foreground = ''${color.bg}
    label-background = ''${color.purple}

    [module/bbd]
    type = custom/text
    label = ""
    label-foreground = ''${color.bg}
    label-background = ''${color.blue}

    [module/bod]
    type = custom/text
    label = ""
    label-foreground = ''${color.bg}
    label-background = ''${color.orange}

    [module/bid]
    type = custom/text
    label = ""
    label-foreground = ''${color.bg}
    label-background = ''${color.indigo}

    ; ───────────────────────── DATE ─────────────────────────

    [module/date]
    type = internal/date
    interval = 1.0
    time = %I:%M %P
    date-alt = "%a, %d %b %Y"
    format = <label>
    format-prefix-background = ''${color.indigo}
    format-prefix-foreground = ''${color.bg}
    label-padding = 4 pt
    label = "%time%%date%"
    label-background = ''${color.indigo}
    label-foreground = ''${color.bg}

    ; ───────────────────────── WEATHER ─────────────────────────

    [module/weather]
    type = custom/script
    exec = curl -s "wttr.in?format=%t" 2>/dev/null || echo ""
    interval = 900
    format = <label>
    label = "%output%"
    label-padding = 2 pt
    label-foreground = ''${color.cyan}

    ; ───────────────────────── WORKSPACE ─────────────────────────

    [module/workspace]
    type = custom/script
    exec = bspc query -D -d focused --names 2>/dev/null || echo ""
    interval = 1
    format = <label>
    label = " %output%"
    label-padding = 4 pt
    label-foreground = ''${color.indigo}

    ; ───────────────────────── FILESYSTEM ─────────────────────────

    [module/filesystem]
    type = internal/fs
    mount-0 = /
    interval = 60
    fixed-values = false
    format-mounted = <label-mounted>
    format-mounted-prefix = 
    format-mounted-prefix-padding = 4 pt
    format-mounted-prefix-foreground = ''${color.bg}
    format-mounted-prefix-background = ''${color.red}
    format-unmounted = <label-unmounted>
    format-unmounted-prefix = 
    format-unmounted-prefix-background = ''${color.red}
    label-mounted = %used%
    label-mounted-padding-right = 4 pt
    label-mounted-foreground = ''${color.bg}
    label-mounted-background = ''${color.red}
    label-unmounted = %mountpoint%: not mounted
    label-unmounted-padding-right = 4 pt
    label-unmounted-foreground = ''${color.bg}
    label-unmounted-background = ''${color.red}

    ; ───────────────────────── NETWORK ─────────────────────────

    [module/network]
    type = internal/network
    interface = ens33
    interval = 3.0
    accumulate-stats = true
    unknown-as-up = true
    speed-unit = ""
    format-connected = <label-connected>
    format-connected-prefix = 
    format-connected-prefix-padding = 4 pt
    label-connected = %netspeed%
    label-connected-padding-right = 4 pt
    format-connected-prefix-foreground = ''${color.bg}
    format-connected-prefix-background = ''${color.orange}
    label-connected-foreground = ''${color.bg}
    label-connected-background = ''${color.orange}
    format-disconnected = <label-disconnected>
    format-disconnected-prefix = 
    format-disconnected-prefix-padding = 4 pt
    format-disconnected-foreground = ''${color.bg}
    format-disconnected-background = ''${color.orange}
    label-disconnected = Offline
    label-disconnected-padding-right = 4 pt
    label-disconnected-foreground = ''${color.bg}
    label-disconnected-background = ''${color.orange}

    ; ───────────────────────── PULSEAUDIO ─────────────────────────

    [module/pulseaudio]
    type = internal/pulseaudio
    use-ui-max = true
    interval = 5
    format-volume = <label-volume>
    format-volume-prefix = ""
    format-volume-prefix-padding = 4 pt
    format-volume-foreground = ''${color.bg}
    format-volume-background = ''${color.blue}
    label-volume = "%percentage%"
    label-volume-padding-right = 4 pt
    label-volume-foreground = ''${color.bg}
    label-volume-background = ''${color.blue}
    format-muted = <label-muted>
    format-muted-prefix = ""
    format-muted-prefix-padding = 4 pt
    format-muted-prefix-foreground = ''${color.bg}
    format-muted-prefix-background = ''${color.blue}
    label-muted = "Muted"
    label-muted-padding-right = 4 pt
    label-muted-background = ''${color.blue}
    label-muted-foreground = ''${color.bg}

    ; ───────────────────────── BRIGHTNESS ─────────────────────────

    [module/brightness]
    type = internal/backlight
    card = intel_backlight
    enable-scroll = false
    format = <ramp><label>
    label = "%percentage%%"
    ramp-0 = 󱩎
    ramp-1 = 󱩎
    ramp-2 = 󱩑
    ramp-3 = 󱩑
    ramp-4 = 󱩓
    ramp-5 = 󱩓
    ramp-6 = 󱩓
    ramp-7 = 󱩖
    ramp-8 = 󱩖
    ramp-9 = 󱩖
    ramp-foreground = ''${color.amber}

    ; ───────────────────────── BATTERY ─────────────────────────

    [module/battery]
    type = internal/battery
    full-at = 99
    battery = BAT0
    adapter = AC
    poll-interval = 2
    time-format = %H:%M
    format-charging = <animation-charging><label-charging>
    label-charging = %percentage%%
    format-discharging = <ramp-capacity><label-discharging>
    label-discharging = %percentage%%
    format-full = <label-full>
    format-full-prefix = 
    label-full = %percentage%%
    ramp-capacity-0 = 
    ramp-capacity-1 = 
    ramp-capacity-2 = 
    ramp-capacity-3 = 
    ramp-capacity-4 = 
    ramp-capacity-foreground = ''${color.yellow}
    ramp-capacity-padding = 4 pt
    animation-charging-0 = 
    animation-charging-1 = 
    animation-charging-2 = 
    animation-charging-3 = 
    animation-charging-4 = 
    animation-charging-foreground = ''${color.green}
    animation-charging-padding = 4 pt
    animation-charging-framerate = 700

    ; ───────────────────────── BSPWM ─────────────────────────

    [module/bspwm]
    type = internal/bspwm
    enable-click = true
    enable-scroll = true
    reverse-scroll = true
    pin-workspaces = true
    occupied-scroll = false
    ws-icon-0 = 1;
    ws-icon-1 = 2;
    ws-icon-2 = 3;
    ws-icon-3 = 4;
    ws-icon-4 = 5;
    ws-icon-5 = 6;
    ws-icon-6 = 7;
    ws-icon-7 = 8;
    ws-icon-8 = 9;
    format = <label-state>
    label-focused = %icon%
    label-focused-padding = 1
    label-focused-foreground = ''${color.lime}
    label-occupied = %icon%
    label-occupied-padding = 1
    label-occupied-foreground = ''${color.purple}
    label-urgent = %icon%
    label-urgent-padding = 1
    label-empty = %icon%
    label-empty-foreground = ''${color.fg}
    label-empty-padding = 1
    label-separator = ""
    label-separator-padding = 0
    label-separator-foreground = ''${color.bg-alt}

    ; ───────────────────────── TITLE ─────────────────────────

    [module/title]
    type = internal/xwindow
    format = <label>
    format-prefix = "󱂬"
    format-prefix-foreground = ''${color.pink}
    label = %title%
    label-padding = 4 pt
    label-maxlen = 30
    label-empty = "Arch Linux"
    label-empty-padding = 4 pt
    label-empty-foreground = ''${color.grey}

    ; ───────────────────────── UPDATES ─────────────────────────

    [module/updates]
    type = custom/ipc
    hook-0 = cat ''${HOME}/.cache/Updates.txt 2>/dev/null
    initial = 1
    format = <label>
    format-prefix = ""
    format-prefix-padding = 4 pt
    format-prefix-foreground = ''${color.bg}
    format-prefix-background = ''${color.green}
    label = %output%
    label-padding-right = 4 pt
    label-foreground = ''${color.bg}
    label-background = ''${color.green}

    ; ───────────────────────── LAUNCHER ─────────────────────────

    [module/launcher]
    type = custom/text
    label = 
    label-foreground = ''${color.blue}
    label-padding = 4
    click-left = rofi -show drun

    ; ───────────────────────── TERMINAL ─────────────────────────

    [module/term]
    type = custom/text
    label = 
    label-foreground = ''${color.green}
    label-padding = 4
    click-left = alacritty

    ; ───────────────────────── FOLDER ─────────────────────────

    [module/folder]
    type = custom/text
    label = 
    label-foreground = ''${color.yellow}
    label-padding = 4
    click-left = yazi

    ; ───────────────────────── BROWSER ─────────────────────────

    [module/browser]
    type = custom/text
    label = 
    label-foreground = ''${color.cyan}
    label-padding = 4
    click-left = librewolf

    ; ───────────────────────── SEPARATORS ─────────────────────────

    [module/sep]
    type = custom/text
    label = " 󰇙 "
    label-foreground = ''${color.indigo}

    [module/sep2]
    type = custom/text
    label = " 󰇙 "
    label-foreground = ''${color.indigo}

    ; ───────────────────────── CPU BAR ─────────────────────────

    [module/cpu_bar]
    type = internal/cpu
    interval = 0.5
    format = <label>
    format-prefix = ""
    format-prefix-padding = 4 pt
    format-prefix-foreground = ''${color.bg}
    format-prefix-background = ''${color.yellow}
    label = "%percentage%%"
    label-padding-right = 4 pt
    label-foreground = ''${color.bg}
    label-background = ''${color.yellow}

    ; ───────────────────────── MEMORY BAR ─────────────────────────

    [module/memory_bar]
    type = internal/memory
    interval = 3
    format = <label>
    format-prefix = ""
    format-prefix-padding = 4 pt
    format-prefix-foreground = ''${color.bg}
    format-prefix-background = ''${color.purple}
    label = "%used%"
    label-padding-right = 4 pt
    label-foreground = ''${color.bg}
    label-background = ''${color.purple}

    ; ───────────────────────── MPLAYER / MUSIC ─────────────────────────

    [module/mplayer]
    type = custom/text
    label = ""
    label-foreground = ''${color.purple}
    label-padding = 4

    ; ───────────────────────── USER CARD ─────────────────────────

    [module/usercard]
    type = custom/text
    label = ""
    label-foreground = ''${color.yellow}
    label-padding = 4
    click-left = fastfetch

    ; ───────────────────────── POWER ─────────────────────────

    [module/power]
    type = custom/text
    label = ""
    label-padding = 4
    label-foreground = ''${color.red}
    click-left = i3lock

    ; ───────────────────────── TRAY ─────────────────────────

    [module/tray]
    type = internal/tray
    format = <tray>
    format-background = ''${color.bg}
    tray-background = ''${color.bg}
    tray-foreground = ''${color.fg}
    tray-spacing = 4px
    tray-padding = 0px
    tray-size = 72%

  '';
}
