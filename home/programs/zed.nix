{ config, pkgs, ... }:

let
  zedWrapper = pkgs.writeShellScriptBin "zed" ''
    export DEEPSEEK_API_KEY="$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")"
    export BRAVE_SEARCH_API_KEY="$(cat /run/secrets/brave_search_api_key 2>/dev/null || echo "")"
    exec ${pkgs.zed-editor}/bin/zed "$@"
  '';
in
{
  home.packages = [ zedWrapper ];

  xdg.desktopEntries."zed" = {
    name = "Zed";
    exec = "${zedWrapper}/bin/zed %F";
    terminal = false;
    categories = [ "Development" "TextEditor" ];
    mimeType = [ "text/plain" ];
  };

  home.file.".config/zed/settings.json" = {
    text = builtins.toJSON {
      theme = {
        mode = "dark";
        dark = "Nightfox Opaque";
        light = "Dayfox Opaque";
      };

      auto_install_extensions = {
        "nvim-nightfox" = true;
      };

      assistant = {
        version = "2";
        button = true;
        default_model = {
          provider = "deepseek";
          model = "deepseek-v4-flash";
        };
      };

      language_models = {
        deepseek = {
          api_url = "https://api.deepseek.com";
          available_models = [
            {
              name = "deepseek-v4-flash";
              display_name = "DeepSeek V4 Flash";
              max_tokens = 1000000;
              max_output_tokens = 384000;
            }
            {
              name = "deepseek-v4-pro";
              display_name = "DeepSeek V4 Pro";
              max_tokens = 1000000;
              max_output_tokens = 384000;
            }
          ];
        };
      };

      mcp_servers = {
        "brave-search" = {
          type = "builtin";
          name = "Brave Search";
        };
      };
    };
  };
}
