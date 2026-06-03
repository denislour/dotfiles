{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = false;
      style = "compact";
      show_preview = true;
      sync_frequency = "5m";
    };
  };
}
