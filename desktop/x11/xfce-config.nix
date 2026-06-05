{ pkgs, ... }: {
  home.file = {
    ".config/autostart/redshift.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Redshift
      Exec=${pkgs.redshift}/bin/redshift -t 5500:4500 -l 10.8:106.7
      X-XFCE-Autostart-Timeout=5
    '';
  };
}
