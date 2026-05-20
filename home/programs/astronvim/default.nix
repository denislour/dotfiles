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
    python3 python3Packages.pyright
    ruby solargraph
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.activation.installAstroNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${config.home.homeDirectory}/.config/nvim" ]; then
      cp -r ${astronvimTemplate} "${config.home.homeDirectory}/.config/nvim"
      chmod -R u+w "${config.home.homeDirectory}/.config/nvim"
    fi
  '';

  home.file.".config/nvim/lua/community.lua".text = ''
    return {
      "AstroNvim/astrocommunity",
      { import = "astrocommunity.pack.rust" },
      { import = "astrocommunity.pack.python" },
      { import = "astrocommunity.pack.ruby" },
    }
  '';

  home.file.".config/nvim/lua/options.lua".text = ''
    vim.opt.relativenumber = true
    vim.opt.number = true
  '';
}
