{config, ...}: {
  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      environmentFiles = [
        config.sops.secrets.wifi_env.path
      ];
      profiles = {
        eduroam = {
            connection = {
            id = "eduroam";
            type = "wifi";
          };
          wifi = {
            mode = "infrastructure";
            ssid = "eduroam";
          };
          wifi-security = {
            key-mgmt = "wpa-eap";
          };
          "802-1x" = {
            eap = "peap";
            identity = "kcjl3+${config.networking.hostName}@cam.ac.uk";
            phase2-auth = "mschapv2";
            password = "$eduroam_${config.networking.hostName}_psk";
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
        home = {
          connection = {
            id = "home";
            type = "wifi";
          };
          wifi = {
            ssid = "$home_ssid";
          };
          "wifi-security" = {
            key-mgmt = "wpa-psk";
            psk = "$home_psk";
          };
        };
      };
    };
  };
}