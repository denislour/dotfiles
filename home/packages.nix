{ pkgs, lib, ... }:

let
  quteLight = pkgs.writeShellScriptBin "qutebrowser" ''
    export QT_STYLE_OVERRIDE=fusion
    exec ${lib.getExe pkgs.qutebrowser} "$@"
  '';
in {
  home.packages = with pkgs; [
    quteLight
    cliphist
    dust
    glow
    just
    procs
    sd
    trunk
    zig
    grim
    slurp
    wl-clipboard
    wl-clip-persist
    wl-gammarelay-rs
    wrangler
    worker-build
    sqlite
  ];

  home.file.".config/qutebrowser/config.py".text = ''
    c.colors.webpage.darkmode.enabled = False
    c.colors.webpage.preferred_color_scheme = "light"
    c.colors.tabs.bg = "#f5f5f5"
    c.colors.tabs.fg = "#333333"
    c.colors.tabs.selected.bg = "#ffffff"
    c.colors.tabs.selected.fg = "#000000"
    c.colors.statusbar.normal.bg = "#f5f5f5"
    c.colors.statusbar.normal.fg = "#333333"
    c.colors.completion.fg = "#333333"
    c.colors.completion.match.fg = "#0066cc"
    c.colors.completion.category.bg = "#e0e0e0"
    c.colors.completion.category.fg = "#000000"
    c.colors.completion.item.selected.bg = "#d0d0d0"
    c.colors.completion.item.selected.fg = "#000000"
    c.fonts.default_size = "14pt"
    c.fonts.monospace = "JetBrainsMono Nerd Font"
  '';
}
