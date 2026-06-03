{ pkgs, ... }:

let
  startSession = pkgs.writeShellScript "start-x11-session" ''
    export XDG_SESSION_TYPE=x11
    export XDG_CURRENT_DESKTOP=i3
    exec ${pkgs.xorg.xinit}/bin/xinit ${pkgs.i3}/bin/i3 -- vt1 -keeptty -novtswitch
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${startSession}";
        user = "jake";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
