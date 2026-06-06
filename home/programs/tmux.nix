{ pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];

  home.file.".tmux.conf".text = ''
    set -g mouse on
  '';
}
