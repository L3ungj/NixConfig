{self, inputs, lib, host, config, pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./llama.nix
    "${self}/nixos/system.nix"
    "${self}/nixos/hyprland.nix"
    "${self}/nixos/plasma.nix"
    "${self}/nixos/sddm.nix"
    "${self}/nixos/steam.nix"
    "${self}/nixos/nh.nix"
    "${self}/nixos/peripherals.nix"
    inputs.lanzaboote.nixosModules.lanzaboote
    "${self}/sops/nixos.nix"
    "${self}/nixos/weylus.nix"
  ];

  boot.loader = {
    systemd-boot = {
      enable = lib.mkForce false;
      configurationLimit = 5;
    };
    timeout = 0;
  };

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  networking = {
    hostName = "aether";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [
          config.sops.secrets.wifi_env.path
        ];
        profiles = {
          chueth = {
              connection = {
                id = "chueth";
                type = "ethernet";
                interface-name = "enp6s0";
            };
            ipv4 = {
              method = "manual";
              addresses = "$chueth_ip";
              gateway = "$chueth_gateway";
              dns = "$chueth_dns";
              dns-search = "chu.cam.ac.uk";
              dhcp-send-hostname = true;
              dhcp-hostname = "$chueth_hostname.chu.cam.ac.uk";
            };
            ipv6.method = "auto";
          };
        };
      };
    };
  };

  boot.kernelModules = [
    "amdgpu"
    "mt7925e"
  ];

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.graphics.enable = true;   
  hardware.enableRedistributableFirmware = true;

  boot.kernelParams = [
    "pcie_aspm=off"
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.settings.trusted-users = host.users;

  # Required by vscodium remote SSH
  programs.nix-ld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
