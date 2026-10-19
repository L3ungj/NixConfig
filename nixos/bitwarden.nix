{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
  ];
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
}