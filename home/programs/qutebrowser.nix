{ pkgs, ... }: {
  home.file.".config/qutebrowser/config.py".text = ''
    import subprocess
    c.colors.tabs.bg = "#f5f5f5"
    c.colors.tabs.fg = "#333333"
    c.colors.tabs.selected.bg = "#ffffff"
    c.colors.tabs.selected.fg = "#000000"
    c.colors.statusbar.normal.bg = "#f5f5f5"
    c.colors.statusbar.normal.fg = "#333333"
    c.colors.statusbar.insert.bg = "#ffffff"
    c.colors.statusbar.insert.fg = "#000000"
    c.colors.prompts.bg = "#ffffff"
    c.colors.prompts.fg = "#000000"
    c.colors.completion.fg = "#333333"
    c.colors.completion.match.fg = "#0066cc"
    c.colors.completion.category.bg = "#e0e0e0"
    c.colors.completion.category.fg = "#000000"
    c.colors.completion.item.selected.bg = "#d0d0d0"
    c.colors.completion.item.selected.fg = "#000000"
    c.colors.webpage.darkmode.enabled = False
    c.colors.webpage.preferred_color_scheme = "light"
    c.fonts.default_size = "14pt"
    c.fonts.monospace = "JetBrainsMono Nerd Font"
    c.zoom.default = "100%"
    c.content.default_encoding = "utf-8"
    c.url.default_page = "https://duckduckgo.com"
    c.url.start_pages = ["https://duckduckgo.com"]
  '';
}
