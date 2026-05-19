{ inputs, ... }:

{
  imports = [
    inputs.zen.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;

    profiles.jake = {
      id = 0;
      name = "jake";
      isDefault = true;

      settings = {
        "widget.wayland" = true;
        "browser.startup.page" = 3;
        "browser.uidensity" = 1;
      };

      search = {
        default = "Google";
        engines = {
          "Google" = {
            keyword = "google.com";
            definedAliases = [ "@g" ];
          };
        };
      };

      extensions = [
        {
          id = "uBlock0@raymondhill.net";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        }
      ];

      userChrome = ''
        #tabbrowser-tabs { visibility: collapse !important; }
        #sidebar-box { --zen-toolbox-width: 35px; }
      '';

      userContent = ''
        @-moz-document url(about:newtab), url(about:home) {
          body { background-color: #1e1e2e !important; }
        }
      '';
    };
  };
}
