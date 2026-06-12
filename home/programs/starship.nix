{ lib, ... }:
let
  inherit (lib) mkForce;
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format = ''
        [](bg:base08 fg:crust)\
        $os\
        $username\
        [](bg:peach fg:base08)\
        $directory\
        [](bg:yellow fg:peach)\
        $git_branch\
        $git_status\
        [ ](fg:base0A)\
        $line_break\
        $character'';

      palette = mkForce "catppuccin_mocha";

      os = {
        disabled = false;
        style = "bg:base08 fg:crust";
      };

      username = {
        show_always = true;
        style_user = "bg:base08 fg:crust";
        style_root = "bg:base08 fg:crust";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:peach fg:crust";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol $branch ](fg:crust bg:yellow)]($style)";
      };

      git_status = {
        style = "bg:yellow";
        format = "[[($all_status$ahead_behind )](fg:crust bg:yellow)]($style)";
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
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[❯](bold fg:base08)";
      };

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };
}
