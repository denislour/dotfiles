{ pkgs, ... }:
let
  slstatusConfig = pkgs.writeText "config.h" ''
    static const char *time_format = "%I:%M %P";
    static const char *date_format = "%a %d %b";

    static const char *battery_dir = "/sys/class/power_supply/BAT0";
    static const char *battery_format = "%c%";

    static const char *wifi_iface = "wlan0";
    static const char *wifi_format = "%s";

    static const char *eth_iface = "eth0";
    static const char *eth_format = "%s";

    static const char *vol_mixer = "Master";
    static const int vol_mixer_channel = 0;

    static const struct arg args[] = {
      { datetime,     "%s ",    date_format },
      { datetime,     "%s  ",   time_format },
      { vol_perc,     "VOL %s%% ",    NULL },
      { wifi_perc,    "NET %s%% ",   wifi_iface },
      { ram_perc,     "RAM %s%% ",   NULL },
      { cpu_perc,     "CPU %s%% ",   NULL },
      { temp,         " %s",    "/sys/class/thermal/thermal_zone0/temp" },
    };
  '';
in {
  nixpkgs.overlays = [
    (self: super: {
      slstatus = super.slstatus.overrideAttrs (old: {
        postPatch = ''
          cp ${slstatusConfig} config.h
        '';
      });
    })
  ];

  home.packages = with pkgs; [ slstatus ];
}
