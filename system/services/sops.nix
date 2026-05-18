{ self, ... }:

{
  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/jake/.config/sops/age/keys.txt";

  sops.secrets.test = { };
}
