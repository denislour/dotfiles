{
  programs.ripgrep = {
    enable = true;
    config = {
      max-columns = 150;
      smart-case = true;
      hidden = true;
      glob = [ "!.git" ];
    };
  };
}
