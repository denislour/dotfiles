{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
    nativeMessagingHosts = [ ];
    pkcs11Modules = [ ];
    enableGnomeExtensions = false;
    settings = {
      "widget.wayland" = true;
      "widget.dmabuf.force-enabled" = true;
      "browser.startup.page" = 3;
      "browser.uidensity" = 1;
      "browser.tabs.drawInTitlebar" = true;
      "browser.compactmode.show" = true;
      "browser.theme.toolbar-theme" = 0;
      "browser.theme.content-theme" = 0;
      "layout.css.prefers-color-scheme.content-override" = 0;
      "ui.systemUsesDarkTheme" = 1;
      "privacy.resistFingerprinting" = false;
      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
    };
    languagePacks = [ ];
    profiles = {
      jake = {
        id = 0;
        name = "jake";
        path = "jake";
        isDefault = true;
        settings = { };
        extraConfig = ''
          pref("privacy.resistFingerprinting", false);
          pref("layout.css.prefers-color-scheme.content-override", 0);
        '';
        userChrome = "";
        userContent = "";
        search = {
          default = "Google";
        };
      };
    };
  };
}
