{ inputs, lib, ... }:

let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  astronvimTemplate = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "template";
    rev = "49a7161b776f8bc6c23508819ea1ad4e7b359bee";
    sha256 = "sha256-zrwpZ6Ow5qL9dml5gJFmLEOlQa02qm/AdFYGlfpw8fY=";
  };

  luaSrc = ./lua;

  astronvimConfig = pkgs.runCommand "astronvim-config" { } ''
    cp -r ${astronvimTemplate} $out
    chmod -R u+w $out
    mkdir -p $out/lua/plugins
    cp "${luaSrc}/community.lua" "$out/lua/community.lua"
    cp "${luaSrc}/options.lua" "$out/lua/options.lua"
    cp "${luaSrc}/plugins/neo-tree.lua" "$out/lua/plugins/neo-tree.lua"
    cp "${luaSrc}/plugins/nightfox.lua" "$out/lua/plugins/nightfox.lua"
    cp "${luaSrc}/plugins/yazi.lua" "$out/lua/plugins/yazi.lua"
    cp "${luaSrc}/plugins/glow.lua" "$out/lua/plugins/glow.lua"
    cp "${luaSrc}/plugins/crystal.lua" "$out/lua/plugins/crystal.lua"
    cp "${luaSrc}/plugins/mint.lua" "$out/lua/plugins/mint.lua"
  '';
in
{
  flake.modules.homeManager.astronvim = { pkgs, lib, config, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withRuby = false;
      withPython3 = false;
    };

    home.packages = with pkgs; [
      rustc cargo rust-analyzer rustfmt
      python3 pyright
      ruby solargraph
      zig
      tree-sitter
      gcc
      vscode-extensions.vadimcn.vscode-lldb
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.activation.installAstroNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      nvim_dir="${config.home.homeDirectory}/.config/nvim"
      mason_dir="${config.home.homeDirectory}/.local/share/nvim/mason"

      rm -rf "$nvim_dir"
      cp -r ${astronvimConfig} "$nvim_dir"
      chmod -R u+w "$nvim_dir"

      mkdir -p "$mason_dir/packages/codelldb"
      ln -sf ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$mason_dir/packages/codelldb/codelldb"
      mkdir -p "$mason_dir/bin"
      ln -sf ../packages/codelldb/codelldb "$mason_dir/bin/codelldb"
    '';
  };
}
