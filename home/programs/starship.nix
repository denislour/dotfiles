{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold.green)";
        error_symbol = "[➜](bold.red)";
      };
      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };
      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
      };
      git_status = { style = "bold yellow"; };
      directory = {
        truncation_length = 3;
        style = "bold cyan";
      };
    };
  };
}
