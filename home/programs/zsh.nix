{ ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;

    initContent = ''
      export DEEPSEEK_API_KEY=$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")

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
