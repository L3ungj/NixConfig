{
  pkgs,
  lib,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    desktopManager.plasma6.enable = true;
  };

  programs.kdeconnect.enable = true;

  xdg.portal = lib.mkForce {
    enable = true;
    xdgOpenUsePortal = true;
    
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    
    config = {
      common = {
        default = [ "kde" "gtk" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "kde" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
      };
    };
  };

}