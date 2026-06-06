{ pkgs, ... }: {
  programs.alacritty.enable = true;

  home.file.".config/alacritty/alacritty.toml".text = ''
    [shell]
    program = "${pkgs.zellij}/bin/zellij"

    [window]
    padding = { x = 8, y = 8 }
    opacity = 1.0

    [font]
    normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
    bold = { family = "JetBrainsMono Nerd Font", style = "Bold" }
    italic = { family = "JetBrainsMono Nerd Font", style = "Italic" }
    size = 14

    [colors.primary]
    background = "#2d353b"
    foreground = "#d3c6aa"

    [colors.normal]
    black = "#2d353b"
    red = "#e67e80"
    green = "#a7c080"
    yellow = "#dbbc7f"
    blue = "#7fbbb3"
    magenta = "#d699b6"
    cyan = "#83c092"
    white = "#d3c6aa"

    [colors.bright]
    black = "#475258"
    red = "#e67e80"
    green = "#a7c080"
    yellow = "#dbbc7f"
    blue = "#7fbbb3"
    magenta = "#d699b6"
    cyan = "#83c092"
    white = "#f8f5e4"

  '';
}
