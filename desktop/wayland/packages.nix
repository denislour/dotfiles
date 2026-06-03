{ pkgs, ... }: {
  home.packages = with pkgs; [
    cliphist grim slurp wl-clipboard wl-clip-persist xwayland-satellite
  ];
}
