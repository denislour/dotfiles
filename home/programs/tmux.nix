{ pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];

  home.file.".tmux.conf".text = ''
    set -g mouse on
    set -g extended-keys on
    set -g extended-keys-format csi-u
    set -as terminal-features 'alacritty*:extkeys'
  '';
}
