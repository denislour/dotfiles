{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;

      format = ''
        [░▒▓](bg:base00 fg:base05)[ $time ](bg:base02 fg:base0D)[▓▒░](bg:base00 fg:base02)$directory$git_branch$git_status$nix_shell$cmd_duration
        [❯](bold base0B) ''$character'';

      character = {
        success_symbol = "[❯](bold base0B)";
        error_symbol = "[❯](bold base08)";
      };

      time = {
        disabled = false;
        format = "🕐 $time";
        style = "bg:base02 fg:base0D";
      };

      directory = {
        truncation_length = 3;
        style = "bg:base00 fg:base0D";
        truncate_to_repo = false;
        format = "[ $path ]($style)";
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        style = "bg:base00 fg:base0E";
      };

      git_status = {
        style = "bg:base00 fg:base0A";
        format = "[\\[$all_status$ahead_behind\\]]($style) ";
      };

      nix_shell = {
        format = "via [$symbol$state( \\($name\\))]($style) ";
        symbol = "❄️ ";
        style = "bg:base00 fg:base0C";
      };

      cmd_duration = {
        format = "took [$duration]($style) ";
        style = "bg:base00 fg:base0A";
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
