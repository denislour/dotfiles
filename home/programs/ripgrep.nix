# ripgrep (rg): grep siêu tốc, tìm kiếm trong code
#   rg pattern     = tìm pattern trong toàn bộ project
#   rg -i pattern  = không phân biệt hoa thường
#   rg -l pattern  = chỉ hiện tên file
{
  programs.ripgrep = {
    enable = true;              # bật ripgrep
    config = {
      max-columns = 150;        # giới hạn độ dài dòng
      smart-case = true;        # tự động case-sensitive nếu pattern có hoa
      hidden = true;            # tìm trong file ẩn
      glob = [ "!.git" ];       # bỏ qua .git
    };
  };
}
