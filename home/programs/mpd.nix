{ pkgs, config, ... }:

let
  homeDir = config.home.homeDirectory;
in {
  services.mpd = {
    enable = true;
    musicDirectory = "${homeDir}/Music";
    playlistDirectory = "${homeDir}/.config/mpd/playlists";
    dbFile = "${homeDir}/.config/mpd/database";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "pulse"
      }
    '';
  };

  programs.ncmpcpp = {
    enable = true;
  };
}
