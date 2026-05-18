# fastfetch: hiển thị thông tin hệ thống khi mở terminal
#   fastfetch         = show system info
#   fastfetch --help  = xem all options
{
  programs.fastfetch = {
    enable = true;              # bật fastfetch
    settings = {
      logo = {
        type = "auto";          # "auto" | "small" | "nixos" | "niri" | ...
        padding = { left = 2; };
      };
      display = {
        separator = " → ";      # ký tự phân cách
        color = "blue";         # màu chữ
      };
      modules = "default";      # modules hiển thị: "default" | "title", "os", "kernel"...
    };
  };
}
