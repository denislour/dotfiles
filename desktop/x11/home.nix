{ pkgs, lib, ... }: {
  imports = [
    ./packages.nix
    ./chadwm.nix
    ./dunst.nix
    ./picom.nix
    ./sxhkd.nix
  ];

  home.activation.installPhoenix = lib.hm.dag.entryAfter ["writeBoundary"] ''
    export PATH="${pkgs.elixir}/bin:${pkgs.erlang}/bin:$PATH"
    mix local.hex --force 2>/dev/null || true
    if ! mix archive.list 2>/dev/null | grep -q phx_new; then
      mix archive.install hex phx_new --force 2>/dev/null || true
    fi
  '';
}
