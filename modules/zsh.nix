{ inputs, ... }:

let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  flake.modules.homeManager.zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      initContent = ''
        source ${pkgs.fzf}/share/fzf/completion.zsh 2>/dev/null || true
        source ${pkgs.fzf}/share/fzf/key-bindings.zsh 2>/dev/null || true
        alias history='atuin history'
        alias ls='eza --icons'
        alias ll='eza -la --icons'
        alias la='eza -A --icons'
        alias lt='eza -T --icons'
        alias cat='bat'
        alias grep='rg'
        alias find='fd'
        alias ps='procs'
        alias du='dust'
        alias diff='delta'
        alias sed='sd'
        alias top='btm'
        alias v='nvim'
        alias g='git'
        alias ff='fastfetch'
      '';
    };

    home.packages = with pkgs; [ fzf ];

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

    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        auto_sync = false;
        style = "compact";
        show_preview = true;
        sync_frequency = "5m";
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd" "cd" ];
    };
  };
}
