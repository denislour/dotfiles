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
      exec = "bash -c 'fastfetch; read -p \"Press enter to exit\"'";
      terminal = true;
      categories = [ "Utility" "System" ];
    };
  };
}
