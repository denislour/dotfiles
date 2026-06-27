{ pkgs, config, lib, ... }:

let
  jsonFormat = pkgs.formats.json { };
  settingsJSON = jsonFormat.generate "zed-settings" {
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    auto_install_extensions = {
      "catppuccin-icons" = true;
      "nix" = true;
      "nvim-nightfox" = true;
      "toml" = true;
      "mcp-server-brave-search" = true;
    };
    auto_update = false;
    use_system_path_prompts = false;
    restore_on_startup = "last_session";
    base_keymap = "JetBrains";
    vim_mode = false;
    relative_line_numbers = "disabled";
    gutter.runnables = false;
    current_line_highlight = "all";
    tab_bar.show = true;
    scrollbar.show = "always";
    toolbar = {
      agent_review = false;
      quick_actions = false;
    };
    indent_guides = {
      enabled = false;
    };
    inlay_hints = {
      enabled = false;
    };
    buffer_line_height = "comfortable";
    show_whitespaces = "all";
    whitespace_map = {
      space = "·";
      tab = "→";
    };
    colorize_brackets = false;
    format_on_save = "on";
    tab_size = 2;
    theme = {
      mode = "dark";
      dark = "Duskfox - blurred";
      light = "Dayfox - opaque";
    };
    icon_theme = "Catppuccin Mocha";
    ui_font_family = "JetBrainsMono Nerd Font";
    ui_font_size = 16;
    buffer_font_family = "JetBrainsMono Nerd Font";
    buffer_font_size = 16;
    buffer_font_features = {
      calt = false;
      dlig = false;
      liga = false;
    };
    terminal.font_size = 16;
    edit_predictions = {
      mode = "subtle";
    };
    git_panel = {
      dock = "left";
    };
    outline_panel = {
      dock = "left";
    };
    project_panel = {
      dock = "left";
    };
    agent = {
      enabled = true;
      dock = "right";
      default_model = {
        provider = "deepseek";
        model = "deepseek-v4-flash";
      };
      tool_permissions = {
        default = "allow";
        tools = {
          terminal = {
            default = "confirm";
            always_allow = [
              { pattern = "^cargo\\s+(build|test|check|run)"; }
              { pattern = "^nix\\s+(build|run|flake|develop|search)"; }
              { pattern = "^home-manager\\s+switch"; }
              { pattern = "^git\\s+(add|commit|push|pull|log|diff|status|branch|checkout)"; }
              { pattern = "^just\\s+(rebuild|update|upgrade|clean)"; }
              { pattern = "^mkdir\\s+-p"; }
              { pattern = "^ls\\b"; }
              { pattern = "^cat\\b"; }
            ];
            always_confirm = [
              { pattern = "sudo\\s+/"; }
              { pattern = "rm\\s+-rf\\s+/"; }
              { pattern = "chmod\\s+777"; }
            ];
          };
          write_file = {
            default = "allow";
            always_confirm = [
              { pattern = "/etc/"; }
              { pattern = "/run/secrets/"; }
            ];
          };
          delete_path = {
            default = "confirm";
          };
          "mcp:mcp-server-brave-search:brave_web_search" = {
            default = "allow";
          };
          "mcp:mcp-server-brave-search:brave_local_search" = {
            default = "allow";
          };
        };
      };
    };
    agent_ui_font_size = 16;
    agent_buffer_font_size = 16;
    languages = {
      Nix = {
        tab_size = 2;
        format_on_save = "on";
        language_servers = [ "nil" ];
      };
      Rust = {
        tab_size = 4;
        format_on_save = "on";
        language_servers = [ "rust-analyzer" ];
      };
      Python = {
        tab_size = 4;
        format_on_save = "on";
        language_servers = [ "pyright" ];
      };
      Markdown = {
        tab_size = 2;
        format_on_save = "on";
        language_servers = [ "marksman" ];
      };
      TOML = {
        tab_size = 2;
        format_on_save = "on";
      };
    };
    lsp = {
      nil = {
        binary.path = "${pkgs.nil}/bin/nil";
        initialization_options = {
          formatting.command = [ "${pkgs.alejandra}/bin/alejandra" "-q" ];
        };
      };
    };
  };

  zedWithKey = pkgs.symlinkJoin {
    name = "zed-with-key";
    paths = [ pkgs.zed-editor ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm -f $out/bin/zeditor
      makeWrapper ${pkgs.zed-editor}/bin/zeditor $out/bin/zeditor \
        --run 'export DEEPSEEK_API_KEY="$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")"' \
        --run 'export ZED_ALLOW_EMULATED_GPU=1'
    '';
  };
in
{
  home.packages = with pkgs; [
    zedWithKey
    rust-analyzer
    rustfmt
    pyright
    marksman
    nil
    alejandra
  ];

  home.file.".config/zed/settings.json" = {
    source = settingsJSON;
    force = true;
  };

  home.file.".config/zed/AGENTS.md".source = ./AGENTS.md;

  home.activation.injectBraveSearchMCP = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings=${config.home.homeDirectory}/.config/zed/settings.json
    secret=$(cat /run/secrets/brave_search_api_key 2>/dev/null || echo "")
    tmp=$(mktemp)
    ${pkgs.jq}/bin/jq --arg key "$secret" '.context_servers["mcp-server-brave-search"].settings.brave_api_key = $key' \
      "$settings" > "$tmp" && mv "$tmp" "$settings"
  '';
}
