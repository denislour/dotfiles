{ pkgs, lib, config, ... }:

let
  astronvimTemplate = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "template";
    rev = "49a7161b776f8bc6c23508819ea1ad4e7b359bee";
    sha256 = "sha256-zrwpZ6Ow5qL9dml5gJFmLEOlQa02qm/AdFYGlfpw8fY=";
  };

  communityLua = builtins.readFile ./lua/community.lua;
  optionsLua = builtins.readFile ./lua/options.lua;
  neoTreeLua = builtins.readFile ./lua/plugins/neo-tree.lua;
  nightfoxLua = builtins.readFile ./lua/plugins/nightfox.lua;
  yaziLua = builtins.readFile ./lua/plugins/yazi.lua;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withRuby = false;
    withPython3 = false;
  };

  home.packages = with pkgs; [
    rustc cargo rust-analyzer rustfmt
    python3 pyright
    ruby solargraph
    tree-sitter
    gcc
    vscode-extensions.vadimcn.vscode-lldb
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.activation.installAstroNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    nvim_dir="${config.home.homeDirectory}/.config/nvim"
    mason_dir="${config.home.homeDirectory}/.local/share/nvim/mason"

    rm -rf "$nvim_dir"
    cp -r ${astronvimTemplate} "$nvim_dir"
    chmod -R u+w "$nvim_dir"
    mkdir -p "$nvim_dir/lua/plugins"
    cat > "$nvim_dir/lua/community.lua" << 'EOF'
    ${communityLua}
    EOF
    cat > "$nvim_dir/lua/options.lua" << 'EOF'
    ${optionsLua}
    EOF
    cat > "$nvim_dir/lua/plugins/neo-tree.lua" << 'EOF'
    ${neoTreeLua}
    EOF
    cat > "$nvim_dir/lua/plugins/nightfox.lua" << 'EOF'
    ${nightfoxLua}
    EOF
    cat > "$nvim_dir/lua/plugins/yazi.lua" << 'EOF'
    ${yaziLua}
    EOF

    mkdir -p "$mason_dir/packages/codelldb"
    ln -sf ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$mason_dir/packages/codelldb/codelldb"
    mkdir -p "$mason_dir/bin"
    ln -sf ../packages/codelldb/codelldb "$mason_dir/bin/codelldb"
  '';
}
