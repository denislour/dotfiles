{ pkgs, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "%h/Music";
    playlistDirectory = "%h/.config/mpd/playlists";
    dbFile = "%h/.config/mpd/database";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "pulse"
      }
    '';
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
  };
}
