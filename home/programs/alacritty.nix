{ pkgs, ... }: {
  programs.alacritty.enable = true;

  home.file.".config/alacritty/alacritty.toml".text = ''
    [terminal.shell]
    program = "${pkgs.zellij}/bin/zellij"

    [window]
    padding = { x = 8, y = 8 }
    opacity = 0.5
    decorations = "Full"

    [font]
    normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
    bold = { family = "JetBrainsMono Nerd Font", style = "Bold" }
    italic = { family = "JetBrainsMono Nerd Font", style = "Italic" }
    size = 14

    [colors.primary]
    background = "#1e1e2e"
    foreground = "#cdd6f4"

    [colors.normal]
    black = "#45475a"
    red = "#f38ba8"
    green = "#a6e3a1"
    yellow = "#f9e2af"
    blue = "#89b4fa"
    magenta = "#f5c2e7"
    cyan = "#94e2d5"
    white = "#bac2de"

    [colors.bright]
    black = "#585b70"
    red = "#f38ba8"
    green = "#a6e3a1"
    yellow = "#f9e2af"
    blue = "#89b4fa"
    magenta = "#f5c2e7"
    cyan = "#94e2d5"
    white = "#a6adc8"

  '';
}
