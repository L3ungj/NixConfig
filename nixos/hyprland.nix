{ pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.geoclue2.enable = true;  # For QtPositioning

  fonts.packages = with pkgs; [
    rubik
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    quickshell
    wl-clipboard
  ];
}