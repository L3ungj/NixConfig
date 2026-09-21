{
  self, 
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-raspberrypi.nixosModules; [
    "${self}/nixos/system.nix"
    raspberry-pi-5.base
    raspberry-pi-5.page-size-16k
    raspberry-pi-5.display-vc4
    raspberry-pi-5.display-rp1
    ./configtxt.nix
  ];

  boot.loader.raspberry-pi.bootloader = "kernel";
  boot.tmp.useTmpfs = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
    options = [ "nofail" ];
  };

  networking.hostName = "radon";

  users.users.root.initialHashedPassword = "";

  # Don't require sudo/root to `reboot` or `poweroff`.
  security.polkit.enable = true;

  # Allow passwordless sudo from nixos user
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  nixpkgs.config.allowUnsupportedSystem = true;

  # Needed for `nixos-rebuild switch --target-host` to accept unsigned closures
  nix.settings.trusted-users = [ "kazu" "tiny" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
