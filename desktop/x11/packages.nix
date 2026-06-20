{ pkgs, ... }: {
  home.packages = with pkgs; [
    feh
    maim
    networkmanagerapplet
    elixir
    elixir_ls
  ];
}
