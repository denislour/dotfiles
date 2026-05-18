{ pkgs, config, ... }:

let
  piWrapper = pkgs.writeShellScriptBin "pi" ''
    export DEEPSEEK_API_KEY=$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")
    exec ${pkgs.pi-coding-agent}/bin/pi "$@"
  '';
in
{
  home.packages = [ piWrapper ];

  home.file.".pi/agent/settings.json".text = builtins.toJSON {
    defaultProvider = "deepseek";
  };
}
