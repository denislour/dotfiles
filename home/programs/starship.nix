{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      line_break.disabled = false;

      character = {
        success_symbol = "[>](bold.green)";
        error_symbol = "[>](bold.red)";
      };

      directory = {
        truncation_length = 3;
        style = "bold cyan";
        truncate_to_repo = false;
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

      nodejs = {
        format = "via [$symbol($version )]($style)";
        symbol = "🔴 ";
        style = "bold green";
        disabled = false;
      };

      python = {
        format = "via [\\[\\$symbol\\$version\\](\\)$style)";
        symbol = "🐍 ";
        style = "bold yellow";
        disabled = false;
      };

      rust = {
        format = "via [$symbol($version )]($style)";
        symbol = "🦀 ";
        style = "bold red";
        disabled = false;
      };

      cmd_duration = {
        format = "took [$duration]($style) ";
        style = "bold yellow";
        show_milliseconds = false;
        min_time = 2000;
      };

      sudo = {
        format = "as [$symbol]($style) ";
        symbol = "🧑‍💻 ";
        style = "bold red";
        disabled = false;
      };

      status = {
        format = "[$symbol]($style) ";
        symbol = "❌ ";
        style = "bold red";
        pipestatus = false;
        disabled = false;
      };

      shell = {
        disabled = false;
        format = "[$indicator]($style) ";
        style = "cyan bold";
        bash_indicator = "bsh";
        zsh_indicator = "zsh";
      };
    };
  };
}
