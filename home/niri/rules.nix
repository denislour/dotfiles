{ ... }:

{
  programs.niri.settings.window-rules = [
    {
      # Bo góc cho tất cả cửa sổ
      matches = [ { } ];
      geometry-corner-radius = {
        top-left = 10.0;
        top-right = 10.0;
        bottom-left = 10.0;
        bottom-right = 10.0;
      };
      clip-to-geometry = true;
    }
  ];
}
