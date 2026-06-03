{ config, self, ... }:

{
  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "${config.users.users.jake.home}/.config/sops/age/keys.txt";

  sops.secrets = {
    brave_search_api_key = { owner = "jake"; mode = "0444"; };
    deepseek_api_key = { owner = "jake"; mode = "0444"; };
  };
}
