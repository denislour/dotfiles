{ pkgs, lib, config, ... }:

let
  astronvimTemplate = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "template";
    rev = "49a7161b776f8bc6c23508819ea1ad4e7b359bee";
    sha256 = "sha256-zrwpZ6Ow5qL9dml5gJFmLEOlQa02qm/AdFYGlfpw8fY=";
  };
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
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.activation.installAstroNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    nvim_dir="${config.home.homeDirectory}/.config/nvim"
    rm -rf "$nvim_dir"
    cp -r ${astronvimTemplate} "$nvim_dir"
    chmod -R u+w "$nvim_dir"
    mkdir -p "$nvim_dir/lua"
    cat > "$nvim_dir/lua/community.lua" << 'EOF'
    return {
      "AstroNvim/astrocommunity",
      { import = "astrocommunity.pack.rust" },
      { import = "astrocommunity.pack.python" },
      { import = "astrocommunity.pack.ruby" },
    }
    EOF
    cat > "$nvim_dir/lua/options.lua" << 'EOF'
    vim.opt.relativenumber = true
    vim.opt.number = true
    EOF
  '';
}
