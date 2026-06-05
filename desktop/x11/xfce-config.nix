{ pkgs, ... }:

let
  disable-panel = pkgs.writeShellScriptBin "disable-panel" ''
    xfconf-query -c xfce4-panel -p /panels -t int -s 0 2>/dev/null || true
  '';

  launch-polybar = pkgs.writeShellScriptBin "launch-polybar" ''
    killall -q polybar 2>/dev/null
    xfce4-panel --quit 2>/dev/null || true
    while pgrep -u "$USER" -x polybar >/dev/null 2>&1; do sleep 0.2; done
    polybar main 2>&1 | tee -a /tmp/polybar.log &
    disown
  '';
in {
  home.packages = [ disable-panel launch-polybar ];

  home.file = {
    ".config/autostart/redshift.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Redshift
      Comment=Night light
      Exec=${pkgs.redshift}/bin/redshift -t 5500:4500 -l 10.8:106.7
      X-XFCE-Autostart-Timeout=5
    '';

    ".config/autostart/disable-panel.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Disable XFCE Panel
      Exec=${disable-panel}/bin/disable-panel
      X-XFCE-Autostart-Timeout=2
    '';

    ".config/autostart/polybar.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Polybar
      Comment=Lightweight status bar
      Exec=${launch-polybar}/bin/launch-polybar
      X-XFCE-Autostart-Timeout=5
    '';
  };
}
