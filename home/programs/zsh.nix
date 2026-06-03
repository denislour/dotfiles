{ pkgs, ... }:

{
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
}
