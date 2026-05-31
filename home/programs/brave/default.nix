{ pkgs, ... }: {
  xdg.mimeApps.enable = true;
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--enable-features=WebContentsForceDark"
      "--ozone-platform-hint=auto"
      "--enable-features=WaylandWindowDecorations"
    ];
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "brave-browser.desktop";
    "x-scheme-handler/https" = "brave-browser.desktop";
    "x-scheme-handler/chrome" = "brave-browser.desktop";
    "text/html" = "brave-browser.desktop";
    "application/x-extension-htm" = "brave-browser.desktop";
    "application/x-extension-html" = "brave-browser.desktop";
    "application/x-extension-shtml" = "brave-browser.desktop";
    "application/xhtml+xml" = "brave-browser.desktop";
    "application/x-extension-xhtml" = "brave-browser.desktop";
    "application/x-extension-xht" = "brave-browser.desktop";
  };
}
