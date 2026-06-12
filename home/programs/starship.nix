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
      palette = mkForce "catppuccin_mocha";

      add_newline = true;

      character = {
        success_symbol = "[[󰄛](green) ❯](peach)";
        error_symbol = "[[󰄛](red) ❯](peach)";
      };

      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold mauve";
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
