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
        /* Chrome/Firefox style - hide Zen sidebar, show horizontal tabs */
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
