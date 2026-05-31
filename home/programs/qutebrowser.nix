{ pkgs, lib, ... }:

let
  quteLight = pkgs.writeShellScriptBin "qutebrowser" ''
    export QT_WEBENGINE_DISABLE_VULKAN=1
    exec ${lib.getExe pkgs.qutebrowser} "$@"
  '';
in {
  programs.qutebrowser = {
    enable = true;
    package = quteLight;
    settings = {
      colors = {
        webpage.darkmode.enabled = false;
        webpage.preferred_color_scheme = "light";
        tabs.odd.bg = "#f5f5f5";
        tabs.odd.fg = "#333333";
        tabs.even.bg = "#f5f5f5";
        tabs.even.fg = "#333333";
        tabs.selected.odd.bg = "#ffffff";
        tabs.selected.odd.fg = "#000000";
        tabs.selected.even.bg = "#ffffff";
        tabs.selected.even.fg = "#000000";
        statusbar.normal.bg = "#f5f5f5";
        statusbar.normal.fg = "#333333";
        completion.fg = "#333333";
        completion.match.fg = "#0066cc";
        completion.category.bg = "#e0e0e0";
        completion.category.fg = "#000000";
        completion.item.selected.bg = "#d0d0d0";
        completion.item.selected.fg = "#000000";
      };
      fonts.default_size = "14pt";
      fonts.web.family.fixed = "JetBrainsMono Nerd Font";
    };
  };
}
