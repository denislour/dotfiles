{ ... }: {
  flake.modules.homeManager.packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      dust glow just procs sd trunk zig crystal mint ameba xrandr wrangler worker-build sqlite
    ];
  };
}
