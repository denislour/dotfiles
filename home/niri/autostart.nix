{ ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "noctalia-shell" ]; }
    # Clipboard persistence — keeps copied content alive after app closes
    { command = [ "wl-clip-persist" "--clipboard" "both" ]; }
    # Clipboard history (text + images)
    { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
    { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }
  ];
}
