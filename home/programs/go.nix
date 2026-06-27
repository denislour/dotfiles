{ config, ... }: {
  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/.cache/go";
    GOMODCACHE = "${config.home.homeDirectory}/.cache/go/pkg/mod";
    GOCACHE = "${config.home.homeDirectory}/.cache/go-build";
  };
}
