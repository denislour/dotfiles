# fd: find nhanh hơn, dễ dùng hơn
#   fd pattern  = tìm file theo tên
#   fd -e md    = tìm file .md
#   fd -x cmd   = chạy lệnh trên kết quả
{
  programs.fd = {
    enable = true;              # bật fd
    hidden = true;              # tìm cả file ẩn (mặc định: false)
    ignores = [ ".git" ];       # bỏ qua thư mục
    extraOptions = [];          # thêm option: [ "--no-ignore" ]
  };
}
