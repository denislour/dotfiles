{
  xdg.desktopEntries = {
    rainfrog = {
      name = "rainfrog";
      comment = "PostgreSQL database management TUI";
      exec = "rainfrog";
      terminal = true;
      categories = [ "Development" "Database" ];
    };
    fastfetch = {
      name = "fastfetch";
      comment = "System information tool";
      exec = "zsh -c 'fastfetch; echo; read -q \"?Press any key to exit...\"; echo'";
      terminal = true;
      categories = [ "Utility" "System" ];
    };
  };
}
