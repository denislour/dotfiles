{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;

      format = ''
        [╭─]($style) [ $directory ](bold base0D)$git_branch$git_status$nix_shell
        [╰─](bold green)$character'';

      character = {
        success_symbol = "[❯](bold base0B)";
        error_symbol = "[❯](bold base08)";
        vicmd_symbol = "[❮](bold base0E)";
      };

      directory = {
        truncation_length = 3;
        style = "bold base0D";
        truncate_to_repo = false;
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold base0E";
      };

      git_status = {
        style = "bold base0A";
        format = "[\\[$all_status$ahead_behind\\]]($style) ";
      };

      nix_shell = {
        format = "via [$symbol$state( \\($name\\))]($style) ";
        symbol = "❄️ ";
        style = "bold base0C";
      };

      nodejs = {
        format = "via [$symbol($version )]($style)";
        symbol = "🔴 ";
        style = "bold base0B";
        disabled = false;
      };

      python = {
        format = "via [$symbol($version )]($style)";
        symbol = "🐍 ";
        style = "bold base0A";
        disabled = false;
      };

      rust = {
        format = "via [$symbol($version )]($style)";
        symbol = "🦀 ";
        style = "bold base08";
        disabled = false;
      };

      cmd_duration = {
        format = "took [$duration]($style) ";
        style = "bold base0A";
        show_milliseconds = false;
        min_time = 2000;
      };

      status = {
        format = "[$symbol]($style) ";
        symbol = "❌ ";
        style = "bold base08";
        pipestatus = false;
        disabled = false;
      };

      line_break.disabled = false;
    };
  };
}
