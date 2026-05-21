{ pkgs, config, ... }:

let
  lspPackages = with pkgs; [
    rust-analyzer
    rustfmt
    pyright
    marksman
    nil
    alejandra
  ];
  lspBinPath = pkgs.buildEnv {
    name = "zed-lsp-env";
    paths = lspPackages;
    pathsToLink = ["/bin"];
  };
  zedWithLSP = pkgs.symlinkJoin {
    name = "zed-with-lsp";
    paths = [pkgs.zed-editor];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      rm -rf $out/bin
      mkdir -p $out/bin
      makeWrapper ${pkgs.zed-editor}/bin/zeditor $out/bin/zeditor \
        --prefix PATH : ${lspBinPath}/bin
      for bin in ${pkgs.zed-editor}/bin/*; do
        if [ "$(basename $bin)" != "zeditor" ]; then
          ln -s $bin $out/bin/$(basename $bin)
        fi
      done
    '';
  };
  settingsJSON = builtins.toJSON {
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    auto_update = false;
    use_system_path_prompts = false;
    restore_on_startup = "last_session";
    vim_mode = false;
    relative_line_numbers = "disabled";
    gutter.runnables = true;
    current_line_highlight = "all";
    tab_bar.show = true;
    scrollbar.show = "never";
    toolbar = {
      agent_review = false;
      quick_actions = false;
    };
    indent_guides = {
      background_coloring = "disabled";
      coloring = "fixed";
    };
    inlay_hints = {
      enabled = true;
      show_background = true;
    };
    show_whitespaces = "selection";
    colorize_brackets = true;
    format_on_save = "on";
    tab_size = 2;
    theme = {
      mode = "light";
      dark = "Duskfox - blurred";
      light = "Dayfox - opaque";
    };
    icon_theme = "Catppuccin Mocha";
    ui_font_family = "JetBrainsMono Nerd Font";
    buffer_font_family = "JetBrainsMono Nerd Font";
    buffer_font_size = 16;
    buffer_font_features = {
      calt = false;
      dlig = false;
      liga = false;
    };
    terminal.font_size = 11;
    features.edit_prediction_provider = "none";
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
  home.packages = [zedWithLSP];

  home.file.".config/zed/settings.json".text = settingsJSON;
}
