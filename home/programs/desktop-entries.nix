{ pkgs, ... }: {
  xdg.desktopEntries = {
    rainfrog = {
      name = "rainfrog";
      comment = "PostgreSQL database management TUI";
      exec = "rainfrog";
      icon = "database";
      terminal = true;
      categories = [ "Development" "Database" ];
    };
    fastfetch = {
      name = "fastfetch";
      comment = "System information tool";
      exec = "${pkgs.writeShellScriptBin "fastfetch-pause" ''
        fastfetch
        echo
        ${pkgs.zsh}/bin/zsh -c 'read -q "?Press any key to exit..."; echo'
      ''}/bin/fastfetch-pause";
      icon = "utilities-system-monitor";
      terminal = true;
      categories = [ "Utility" "System" ];
    };
  };
}
