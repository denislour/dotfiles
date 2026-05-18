# delta: diff hiện đại, syntax highlight + side-by-side
#   git diff  = tự động dùng delta (nếu config git)
#   diff file1 file2 = delta (alias từ zsh.nix)
{
  programs.delta = {
    enable = true;              # bật delta
    options = {
      line-numbers = true;      # hiện số dòng
      side-by-side = true;      # chế độ 2 cột
      navigate = true;          # cho phép điều hướng (n/N)
      light = false;            # theme tối
      syntax-theme = "catppuccin-mocha"; # theme màu
    };
  };
}
