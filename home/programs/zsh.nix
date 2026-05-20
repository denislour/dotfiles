{ ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    initExtra = ''
      ZED_TOKEN=$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")
      export ZED_TOKEN
    '';
    initContent = ''
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
      alias z='zeditor'
    '';
  };
}
