{ pkgs, ... }: {
  home.packages = with pkgs; [ dunst ];

  xdg.configFile."dunst/dunstrc".text = ''
    [global]
    monitor = 0
    follow = mouse
    geometry = "300x5-20+60"
    origin = top-right
    offset = "20x60"
    notification_limit = 5
    progress_bar = true
    indicate_hidden = yes
    transparency = 0
    corner_radius = 6
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    text_icon_padding = 0
    frame_width = 0
    frame_color = "#a7c080"
    separator_color = frame
    sort = no
    idle_threshold = 120
    font = "JetBrainsMono NF Medium 9"
    line_height = 0
    markup = full
    format = "<b>%s</b>\\n%b"
    alignment = left
    vertical_alignment = center
    show_age_threshold = 60
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes
    icon_position = left
    min_icon_size = 32
    max_icon_size = 64
    icon_path = /run/current-system/sw/share/icons/hicolor/48x48/status
    sticky_history = yes
    history_length = 20
    dmenu = /run/current-system/sw/bin/rofi -dmenu
    browser = /run/current-system/sw/bin/brave
    always_run_script = true
    mouse_left_click = close_current
    mouse_middle_click = do_action
    mouse_right_click = close_all

    [urgency_low]
    background = "#2d353b"
    foreground = "#d3c6aa"
    timeout = 10

    [urgency_normal]
    background = "#2d353b"
    foreground = "#d3c6aa"
    timeout = 10

    [urgency_critical]
    background = "#e67e80"
    foreground = "#2d353b"
    timeout = 0
  '';
}
