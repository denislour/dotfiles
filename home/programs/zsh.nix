{ ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    initContent = ''
      # SSH agent (auto-start once per login)
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null 2>&1
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
      fi

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
      alias v='vim'
      alias g='git'
    '';
  };
}
