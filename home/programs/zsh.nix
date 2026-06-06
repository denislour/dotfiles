{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      path = "/dev/null";
      size = 0;
      save = 0;
    };
    initContent = ''
      [[ -z "$TMUX" && "$TERM" != "dumb" && "$TERM_PROGRAM" != "vscode" ]] && {
        tmux attach 2>/dev/null || tmux new -s main
      }
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
      export PKG_CONFIG_PATH="${pkgs.sqlite.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
    '';
  };

  home.packages = with pkgs; [ fzf ];
}
