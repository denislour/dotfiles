{
  programs.librewolf = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        "signon.rememberSignons" = true;
        "network.cookie.lifetimePolicy" = 0;
        "privacy.resistFingerprinting" = false;
        "privacy.firstparty.isolate" = false;
      };
    };
  };
}
