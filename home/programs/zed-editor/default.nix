{ pkgs, config, lib, ... }:

let
  zedWrapper = pkgs.writeShellScriptBin "zeditor" ''
    export DEEPSEEK_API_KEY="$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")"
    exec ${lib.getExe pkgs.zed-editor} "$@"
  '';
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
    vim_mode = false;
    relative_line_numbers = "disabled";
    gutter.runnables = true;
    current_line_highlight = "all";
    tab_bar.show = true;
    scrollbar.show = "always";
    toolbar = {
      agent_review = false;
      quick_actions = false;
    };
    indent_guides = {
      enabled = true;
      background_coloring = "disabled";
      coloring = "fixed";
      line_width = 1;
    };
    inlay_hints = {
      enabled = true;
      show_background = true;
    };
    buffer_line_height = "comfortable";
    show_whitespaces = "selection";
    colorize_brackets = true;
    format_on_save = "on";
    tab_size = 2;
    theme = {
      mode = "dark";
      dark = "Duskfox - blurred";
      light = "Dayfox - opaque";
    };
    icon_theme = "Catppuccin Mocha";
    ui_font_family = "JetBrainsMono Nerd Font";
    ui_font_size = 22;
    buffer_font_family = "JetBrainsMono Nerd Font";
    buffer_font_size = 22;
    buffer_font_features = {
      calt = false;
      dlig = false;
      liga = false;
    };
    terminal.font_size = 22;
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
    };
    agent_ui_font_size = 22;
    agent_buffer_font_size = 22;
    languages = {
      Nix = {
        tab_size = 2;
        format_on_save = "on";
        language_servers = ["nil"];
      };
      Rust = {
        tab_size = 4;
        format_on_save = "on";
        language_servers = ["rust-analyzer"];
      };
      Python = {
        tab_size = 4;
        format_on_save = "on";
        language_servers = ["pyright"];
      };
      Markdown = {
        tab_size = 2;
        format_on_save = "on";
        language_servers = ["marksman"];
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
          formatting.command = ["${pkgs.alejandra}/bin/alejandra" "-q"];
        };
      };
    };
  };
in
{
  home.packages = with pkgs; [
    zedWrapper
    rust-analyzer
    rustfmt
    pyright
    marksman
    nil
    alejandra
  ];

  home.file.".config/zed/settings.json".source = settingsJSON;

  home.activation.injectBraveSearchMCP = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.jq}/bin/jq '.context_servers["mcp-server-brave-search"].settings.brave_api_key = $api_key' \
      --arg api_key "$(cat /run/secrets/brave_search_api_key 2>/dev/null || echo "")" \
      ${config.home.homeDirectory}/.config/zed/settings.json > /tmp/zed-settings.json \
      && mv /tmp/zed-settings.json ${config.home.homeDirectory}/.config/zed/settings.json
  '';
}
