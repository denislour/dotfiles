{ pkgs, ... }: {
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
      exec = "${pkgs.writeShellScriptBin "fastfetch-pause" ''
        fastfetch
        echo
        ${pkgs.zsh}/bin/zsh -c 'read -q "?Press any key to exit..."; echo'
      ''}/bin/fastfetch-pause";
      terminal = true;
      categories = [ "Utility" "System" ];
    };
  };
}
