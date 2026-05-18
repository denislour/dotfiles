# eza: ls hiện đại, có icon + màu + tree view
#   ls  = eza --icons  (alias từ zsh.nix)
#   ll  = eza -la --icons
#   lt  = eza -T --icons (tree)
{
  programs.eza = {
    enable = true;              # bật eza
    enableZshIntegration = true; # alias ls → eza (nếu chưa có alias)
    icons = true;               # hiển thị icon 📁📄
    colors = true;              # màu sắc
    extraOptions = [];          # thêm option VD: [ "--group-directories-first" ]
    git = true;                 # hiển thị trạng thái git
  };
}
