{inputs, lib, ...}: let
  sapin_ip = "100.115.66.69";
  aether_ip = "100.95.110.77";
  phone_ip = "100.66.215.29";
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
        "ac:05:3b:15:ca:60:5c:bc:18:6a:a4:f1:ef:e2:d4:ff:d6:99:60:61:a3:bc:28:8a:4a:f6:cf:3a:ae:93:fe:cf" = "aether";
        "7a:3e:61:de:fc:f0:c7:41:e4:16:e1:f3:92:5d:a3:25:46:a6:28:94:b5:00:05:51:81:cc:df:be:95:a3:36:2a" = "sapin";
      };

      clients = [
        {
          position = "left";
          hostname = "sapin";
          ips = [sapin_ip];
        }
        {
          position = "right";
          hostname = "aether";
          ips = [aether_ip];
        }
      ];
    };
  };

  # KDE Connect
  services.kdeconnect.enable = true;
  xdg.configFile."kdeconnect/config".text = ''
    [General]
    customDevices=${sapin_ip},${aether_ip},${phone_ip}
  '';
}
