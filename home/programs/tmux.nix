{ ... }: {
  home.file.".tmux.conf".text = ''
    # === Mouse ===
    set -g mouse on

    # === Base index (start at 1) ===
    set -g base-index 1
    setw -g pane-base-index 1
    set-option -g renumber-windows on

    # === Vi mode keys ===
    set -g mode-keys vi
    set -g status-keys vi

    # === Colors (256 + true color) ===
    set -g default-terminal "tmux-256color"
    set -ga terminal-overrides ",*:Tc"
    set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

    # === Split panes (v/h) in current dir ===
    bind '"' split-window -v -c "#{pane_current_path}"
    bind '%' split-window -h -c "#{pane_current_path}"

    # === Easy pane navigation (vim-style) ===
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # === Resize panes with Alt + hjkl ===
    bind -n M-h resize-pane -L 2
    bind -n M-j resize-pane -D 2
    bind -n M-k resize-pane -U 2
    bind -n M-l resize-pane -R 2

    # === Smart pane switching with awareness of vim/nvim ===
    bind -T copy-mode-vi C-h select-pane -L
    bind -T copy-mode-vi C-j select-pane -D
    bind -T copy-mode-vi C-k select-pane -U
    bind -T copy-mode-vi C-l select-pane -R

    # === Reload config ===
    bind r source-file ~/.tmux.conf \; display "Config reloaded!"

    # === History limit ===
    set -g history-limit 50000

    # === Status bar ===
    set -g status-interval 5
    set -g status-left-length 60
    set -g status-right-length 120
    set -g status-justify left

    # Colors
    set -g status-style "bg=#2d353b,fg=#d3c6aa"

    # Windows
    setw -g window-status-format " #I:#W "
    setw -g window-status-current-format " #I:#W "
    setw -g window-status-style "bg=#475258,fg=#d3c6aa"
    setw -g window-status-current-style "bg=#7fbbb3,fg=#2d353b"
    setw -g window-status-separator ""

    # Left: session name
    set -g status-left "#[fg=#2d353b,bg=#7fbbb3,bold]  #S #[fg=#7fbbb3,bg=#2d353b,nobold]"

    # Right: date + time
    set -g status-right "#[fg=#d3c6aa,bg=#475258] %Y-%m-%d %H:%M "

    # === Pane border ===
    set -g pane-border-style "fg=#475258"
    set -g pane-active-border-style "fg=#7fbbb3"

    # === Messages ===
    set -g message-style "bg=#7fbbb3,fg=#2d353b"
    set -g message-command-style "bg=#2d353b,fg=#d3c6aa"
  '';
}
