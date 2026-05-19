{ pkgs, inputs, ... }:

{
  imports = [
    inputs.zen.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;
    package = inputs.zen.packages.${pkgs.stdenv.hostPlatform.system}.default;

    profiles.jake = {
      id = 0;
      name = "jake";
      isDefault = true;

      settings = {
        "widget.wayland" = true;
        "browser.startup.page" = 3;
        "browser.uidensity" = 1;
        "widget.dmabuf.force-enabled" = true;
        "full-screen-api.ignore-widgets" = true;
        "zen.tabs.vertical" = false;
        "zen.theme.essentials-header" = false;
        "zen.view.sidebar-expanded" = false;
        "zen.theme.accent-color" = "#89b4fa";
        "browser.compactmode.show" = true;
        "browser.tabs.drawInTitlebar" = true;
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 1;
          newElementCount = 0;
          placements = {
            "PersonalToolbar" = [ "personal-bookmarks" ];
            "nav-bar" = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "zen-split-views-button"
              "downloads-button"
              "sidebar-button"
            ];
            "TabsToolbar" = [
              "tabbrowser-tabs"
              "alltabs-button"
            ];
            "widget-overflow-fixed-list" = [ ];
          };
          seen = [
            "back-button"
            "forward-button"
            "stop-reload-button"
            "urlbar-container"
            "zen-split-views-button"
            "downloads-button"
            "personal-bookmarks"
            "sidebar-button"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "PersonalToolbar"
            "TabsToolbar"
            "widget-overflow-fixed-list"
          ];
        };
      };

      search = {
        default = "google";
        engines = {
          "google" = {
            keyword = "google.com";
            definedAliases = [ "@g" ];
          };
        };
      };

      userChrome = ''
        #sidebar-box { display: none !important; }
        #sidebar-splitter { display: none !important; }
      '';

      userContent = ''
        @-moz-document url(about:newtab), url(about:home) {
          body { background-color: #1e1e2e !important; }
        }
      '';
    };
  };
}
