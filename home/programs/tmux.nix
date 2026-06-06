{ pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];

  home.file.".tmux.conf".text = ''
    set -g mouse on
    set -g extended-keys on
    set -g extended-keys-format csi-u

    set -g base-index 1
    setw -g pane-base-index 1
    set-option -g renumber-windows on

    set -g mode-keys vi
    set -g status-keys vi

    set -g default-terminal "tmux-256color"
    set -ga terminal-overrides ",*:Tc"
    set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
    set -ga terminal-overrides '*:kbs=^?'

    bind '"' split-window -v -c "#{pane_current_path}"
    bind '%' split-window -h -c "#{pane_current_path}"

    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    bind -n M-h resize-pane -L 2
    bind -n M-j resize-pane -D 2
    bind -n M-k resize-pane -U 2
    bind -n M-l resize-pane -R 2

    bind -T copy-mode-vi C-h select-pane -L
    bind -T copy-mode-vi C-j select-pane -D
    bind -T copy-mode-vi C-k select-pane -U
    bind -T copy-mode-vi C-l select-pane -R

    bind r source-file ~/.tmux.conf \; display "Config reloaded!"

    set -g destroy-unattached on

    set -g history-limit 50000

    set -g status-interval 5
    set -g status-left-length 60
    set -g status-right-length 120
    set -g status-justify left

    set -g status-style "bg=#2d353b,fg=#d3c6aa"

    setw -g window-status-format " #I:#W "
    setw -g window-status-current-format " #I:#W "
    setw -g window-status-style "bg=#475258,fg=#d3c6aa"
    setw -g window-status-current-style "bg=#7fbbb3,fg=#2d353b"
    setw -g window-status-separator ""

    set -g status-left "#[fg=#2d353b,bg=#7fbbb3,bold]  #S #[fg=#7fbbb3,bg=#2d353b,nobold]"
    set -g status-right "#[fg=#d3c6aa,bg=#475258] %Y-%m-%d %H:%M "

    set -g pane-border-style "fg=#475258"
    set -g pane-active-border-style "fg=#7fbbb3"

    set -g message-style "bg=#7fbbb3,fg=#2d353b"
    set -g message-command-style "bg=#2d353b,fg=#d3c6aa"
  '';
}
