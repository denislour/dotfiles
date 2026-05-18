{ config, ... }:

{
  programs.pi.coding-agent = {
    enable = true;
    users = [ "jake" ];

    environment = {
      DEEPSEEK_API_KEY = config.sops.secrets.deepseek_api_key.path;
    };

    extraFlags = [
      "--provider" "deepseek"
    ];
  };
}
