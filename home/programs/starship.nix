{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[>](bold.green)";
        error_symbol = "[>](bold.red)";
      };
      nix_shell = {
        format = "via [$state( \\($name\\))]($style) ";
      };
      git_branch = {
        format = "on [$branch(:$remote_branch)]($style) ";
      };
      directory = {
        truncation_length = 3;
        style = "bold cyan";
      };
    };
  };
}
