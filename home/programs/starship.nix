{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "[](bg:base08 fg:base00)$os$username[](bg:base09 fg:base08)$directory[](bg:base0A fg:base09)$git_branch$git_status[ ](fg:base0A)$line_break$character";

      os = {
        disabled = false;
        style = "bg:base08 fg:base00";
      };

      username = {
        show_always = true;
        style_user = "bg:base08 fg:base00";
        style_root = "bg:base08 fg:base00";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:base09 fg:base00";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = "";
        style = "bg:base0A";
        format = "[[ $symbol $branch ](fg:base00 bg:base0A)]($style)";
      };

      git_status = {
        style = "bg:base0A";
        format = "[[($all_status$ahead_behind )](fg:base00 bg:base0A)]($style)";
      };

      nix_shell = {
        format = "via [$symbol$state( \\($name\\))]($style) ";
        symbol = "❄️ ";
        style = "bg:base00 fg:base0C";
      };

      cmd_duration = {
        format = "took [$duration]($style) ";
        style = "bold base0A";
        show_milliseconds = false;
        min_time = 2000;
      };

      line_break.disabled = true;

      character = {
        success_symbol = "[❯](bold fg:base0B)";
        error_symbol = "[❯](bold fg:base08)";
      };
    };
  };
}
