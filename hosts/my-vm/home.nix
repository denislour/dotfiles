{ config, pkgs, ... }:

{
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  imports = [
    ../../home/niri
    ../../home/programs/atuin.nix
    ../../home/programs/bat.nix
    ../../home/programs/bottom.nix
    ../../home/programs/starship.nix
    ../../home/programs/zen-browser.nix
    ../../home/programs/delta.nix
    ../../home/programs/eza.nix
    ../../home/programs/fastfetch.nix
    ../../home/programs/fd.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/git.nix
    ../../home/programs/pi
    ../../home/programs/ripgrep.nix
    ../../home/programs/yazi.nix
    ../../home/programs/zoxide.nix
    ../../home/programs/zsh.nix
  ];

  home.packages = import ./packages.nix { inherit pkgs; };

  programs.home-manager.enable = true;

  home.file.".config/zed/settings.json" = {
    text = builtins.toJSON {
      assistant = {
        version = "2";
        default_model = {
          provider = "deepseek";
          model = "deepseek-v4-flash";
        };
        button = true;
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
    };
  };
}
