{ ... }:

{
  programs.niri.settings.window-rules = [
    {
      matches = [ { } ];
      geometry-corner-radius = {
        top-left = 10.0;
        top-right = 10.0;
        bottom-left = 10.0;
        bottom-right = 10.0;
      };
      clip-to-geometry = true;
    }

    {
      matches = [
        { app-id = "^librewolf$"; }
      ];
      open-fullscreen = false;
    }
  ];
}
