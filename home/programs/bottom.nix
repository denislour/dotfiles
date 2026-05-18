# bottom (btm): top/htop hiện đại, có chart + mouse support
#   btm         = mở TUI monitor
#   btm -b      = chế độ battery
#   alias top='btm' (từ zsh.nix)
{
  programs.bottom = {
    enable = true;              # bật bottom
    settings = {
      flags = {
        color = "default";      # "default" | "dark" | "light"
        group = true;           # group processes
        mem_as_value = false;   # hiện memory dạng value
        tree = false;           # chế độ cây
      };
    };
  };
}
