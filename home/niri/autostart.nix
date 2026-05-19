{ pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "noctalia-shell" ]; }

    { command = [ "wl-clip-persist" "--clipboard" "both" ]; }

    { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
    { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }

    # Đảm bảo GTK portal backend chạy để Zed (và các app khác) có thể mở folder/file dialog
    { command = [ "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk" ]; }
  ];
}
