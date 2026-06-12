{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;

      format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      directory = {
        truncation_length = 3;
        style = "bold cyan";
        truncate_to_repo = false;
        prefix = " ";
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold purple";
      };

      git_status = {
        style = "bold yellow";
        format = "[\\[$all_status$ahead_behind\\]]($style) ";
      };

      nix_shell = {
        format = "via [$symbol$state( \\($name\\))]($style) ";
        symbol = "❄️ ";
        style = "bold blue";
      };

      cmd_duration = {
        format = "took [$duration]($style) ";
        style = "bold yellow";
        show_milliseconds = false;
        min_time = 2000;
      };

      status = {
        format = "[$symbol]($style) ";
        symbol = "❌ ";
        style = "bold red";
        pipestatus = false;
        disabled = false;
      };

      line_break.disabled = false;
    };
  };
}
