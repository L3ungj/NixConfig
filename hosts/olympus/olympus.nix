{
  self, 
  config,
  pkgs,
  inputs,
  host,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${self}/nixos/system.nix"
    "${self}/nixos/hyprland.nix"
    "${self}/nixos/plasma.nix"
    "${self}/nixos/sddm.nix"
    "${self}/nixos/nh.nix"
    "${self}/nixos/peripherals.nix"
    "${self}/sops/nixos.nix"
    "${self}/nixos/weylus.nix"
    "${self}/nixos/wifi.nix"
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
    efi.canTouchEfiVariables = false;
    timeout = 0;
  };

  networking.hostName = "olympus";

  nix.settings.trusted-users = host.users;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
