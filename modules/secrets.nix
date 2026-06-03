{ inputs, ... }: {
  flake.modules.nixos.secrets = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops.age.keyFile = "/home/jake/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ../secrets/secrets.yaml;

    sops.secrets = {
      deepseek_api_key = { };
      brave_search_api_key = { };
    };
  };
}
