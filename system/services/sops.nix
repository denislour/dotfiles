{ self, ... }:

{
  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
}
