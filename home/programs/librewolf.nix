{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    settings = {
      # Wayland support
      "widget.wayland" = true;
      "widget.dmabuf.force-enabled" = true;

      # Startup
      "browser.startup.page" = 3;

      # UI tweaks
      "browser.uidensity" = 1;
      "browser.tabs.drawInTitlebar" = true;
      "browser.compactmode.show" = true;

      # Dark theme
      "browser.theme.toolbar-theme" = 0;
      "browser.theme.content-theme" = 0;
    };
    search = {
      default = "google";
    };
  };
}
