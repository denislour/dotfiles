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
