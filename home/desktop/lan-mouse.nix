{inputs, lib, ...}: let
  sapin_ip = "100.115.66.69";
  aether_ip = "100.95.110.77";
  aether_win_ip = "100.121.178.60";
in {
  imports = [
    inputs.lan-mouse.homeManagerModules.default
  ];

  programs.lan-mouse = {
    enable = true;
    systemd = true;
    settings = {
      release_bind = ["KeyA" "KeyS" "KeyD" "KeyF"];

      authorized_fingerprints = {
        "89:40:cd:fe:67:38:6c:95:dd:4d:4a:e4:01:a7:0d:2b:a8:7b:a2:a0:ca:68:81:8c:27:1b:5a:3d:bc:ef:01:fe" = "WIN-K8MUHNRK2LB";
        "ac:05:3b:15:ca:60:5c:bc:18:6a:a4:f1:ef:e2:d4:ff:d6:99:60:61:a3:bc:28:8a:4a:f6:cf:3a:ae:93:fe:cf" = "aether";
        "7a:3e:61:de:fc:f0:c7:41:e4:16:e1:f3:92:5d:a3:25:46:a6:28:94:b5:00:05:51:81:cc:df:be:95:a3:36:2a" = "sapin";
      };

      clients = [
        {
          position = "left";
          hostname = "sapin";
          activate_on_startup = true;
          ips = [sapin_ip];
        }
        {
          position = "right";
          hostname = "aether";
          activate_on_startup = true;
          ips = [aether_ip];
        }
      ];
    };
  };

  systemd.user.services.lan-mouse.Install.WantedBy = ["graphical-session.target"];

  # KDE Connect
  services.kdeconnect.enable = true;
  xdg.configFile."kdeconnect/config".text = ''
    [General]
    customDevices=${sapin_ip},${aether_ip},${aether_win_ip}
  '';

  xdg.configFile."kdeconnect/trusted_devices".text = ''
    [2b3340ce5d7041ff9ab1de2c97c45413]
    certificate=-----BEGIN CERTIFICATE-----\nMIIBnTCCAUSgAwIBAgIUGFQwchwyvXa/qIhq+XakhYNBF18wCgYIKoZIzj0EAwQw\nTzEpMCcGA1UEAwwgMmIzMzQwY2U1ZDcwNDFmZjlhYjFkZTJjOTdjNDU0MTMxDDAK\nBgNVBAoMA0tERTEUMBIGA1UECwwLS0RFIENvbm5lY3QwHhcNMjUwODI4MTQzMjU3\nWhcNMzYwODI1MTQzMjU3WjBPMSkwJwYDVQQDDCAyYjMzNDBjZTVkNzA0MWZmOWFi\nMWRlMmM5N2M0NTQxMzEMMAoGA1UECgwDS0RFMRQwEgYDVQQLDAtLREUgQ29ubmVj\ndDBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABDIVr9Tp9mqYqxqmPNkA4xAxaVTu\nP302TkZnly+hcM2/UziHYrn1AV874BZFaJcKdaL6XCBdpV1u9f46ibT1dikwCgYI\nKoZIzj0EAwQDRwAwRAIgN69Zej5VWgDwyV5o1w5KG+G7o1Iru2+QZPi5I0kFFzUC\nICMGqqVsdFv8/hUc3qXXi88uBm5AyEAgEQVFEzpnWAmt\n-----END CERTIFICATE-----\n
    name=sapin
    protocolVersion=8
    type=desktop

    [a88e7f691ff4491c82814724c16c163c]
    certificate="-----BEGIN CERTIFICATE-----\nMIIBnjCCAUWgAwIBAgIVAICAoxCTqSfyclFbsgLo7bT37L9vMAoGCCqGSM49BAME\nME8xKTAnBgNVBAMMIGE4OGU3ZjY5MWZmNDQ5MWM4MjgxNDcyNGMxNmMxNjNjMQww\nCgYDVQQKDANLREUxFDASBgNVBAsMC0tERSBDb25uZWN0MB4XDTI1MDgyODE0Mjcy\nNFoXDTM2MDgyNTE0MjcyNFowTzEpMCcGA1UEAwwgYTg4ZTdmNjkxZmY0NDkxYzgy\nODE0NzI0YzE2YzE2M2MxDDAKBgNVBAoMA0tERTEUMBIGA1UECwwLS0RFIENvbm5l\nY3QwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAATQWnbpm1H4YTE71r73obAVyd1M\nW1MgCJr4t6KgLrJPdbXb+Ic4sQvDper3gOlOgNmGeqXbKrOcRlO6PCEFZkX2MAoG\nCCqGSM49BAMEA0cAMEQCIG4V1jt5IW8pU+yq7Krq56lyJscsMYGW+pSXkOXWhoBK\nAiBqznxUSlA/QekP6MvHxLMB1Q9iN79ejefmvwITcIiGXw==\n-----END CERTIFICATE-----\n"
    name=aether
    protocolVersion=8
    type=desktop

    [51ba874b6ca44b39b804f7d0aaf0769b]
    certificate=-----BEGIN CERTIFICATE-----\nMIIBizCCATGgAwIBAgIBATAKBggqhkjOPQQDBDBPMSkwJwYDVQQDDCA1MWJhODc0\nYjZjYTQ0YjM5YjgwNGY3ZDBhYWYwNzY5YjEUMBIGA1UECwwLS0RFIENvbm5lY3Qx\nDDAKBgNVBAoMA0tERTAeFw0yNTA1MDYyMzAwMDBaFw0zNjA1MDYyMzAwMDBaME8x\nKTAnBgNVBAMMIDUxYmE4NzRiNmNhNDRiMzliODA0ZjdkMGFhZjA3NjliMRQwEgYD\nVQQLDAtLREUgQ29ubmVjdDEMMAoGA1UECgwDS0RFMFkwEwYHKoZIzj0CAQYIKoZI\nzj0DAQcDQgAEZlgBsF0YpXnhG2H5lLd99rAvHU6e2uyayQ/rcwQ+AzktOUW/iply\n/dYsN6kuF2zpF+0RI+7u/lvJFd0ibAx6ITAKBggqhkjOPQQDBANIADBFAiEAxvKV\n/arGKsRmx6LoHUv+sFDP55c9Kc3sKXsW8nsqmRwCIBeyEijIrC3rW6lofAmn/MbR\nAzHn83NdBO9pSJDrZulF\n-----END CERTIFICATE-----\n
    name=Nothing Phone 3a
    protocolVersion=8
    type=phone
  '';
}
