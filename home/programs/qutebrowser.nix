{ pkgs, lib, ... }:

let
  quteLight = pkgs.writeShellScriptBin "qutebrowser" ''
    export QT_STYLE_OVERRIDE=fusion
    exec ${lib.getExe pkgs.qutebrowser} "$@"
  '';
in {
  home.packages = [ quteLight ];

  home.file.".config/qutebrowser/config.py".text = ''
    config.load_autoconfig(False)
    c.colors.webpage.darkmode.enabled = False
    c.colors.webpage.preferred_color_scheme = "light"
    c.colors.tabs.odd.bg = "#f5f5f5"
    c.colors.tabs.odd.fg = "#333333"
    c.colors.tabs.even.bg = "#f5f5f5"
    c.colors.tabs.even.fg = "#333333"
    c.colors.tabs.selected.odd.bg = "#ffffff"
    c.colors.tabs.selected.odd.fg = "#000000"
    c.colors.tabs.selected.even.bg = "#ffffff"
    c.colors.tabs.selected.even.fg = "#000000"
    c.colors.statusbar.normal.bg = "#f5f5f5"
    c.colors.statusbar.normal.fg = "#333333"
    c.colors.completion.fg = "#333333"
    c.colors.completion.match.fg = "#0066cc"
    c.colors.completion.category.bg = "#e0e0e0"
    c.colors.completion.category.fg = "#000000"
    c.colors.completion.item.selected.bg = "#d0d0d0"
    c.colors.completion.item.selected.fg = "#000000"
    c.fonts.default_size = "14pt"
    c.fonts.web.family.fixed = "JetBrainsMono Nerd Font"
  '';
}
