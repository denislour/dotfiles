{ self, ... }:

{
  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/jake/.config/sops/age/keys.txt";

  sops.secrets = {
    test = { owner = "jake"; mode = "0444"; };
    brave_search_api_key = { owner = "jake"; mode = "0444"; };
    deepseek_api_key = { owner = "jake"; mode = "0444"; };
  };
}
