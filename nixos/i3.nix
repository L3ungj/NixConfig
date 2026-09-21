{pkgs, ...}: {
  services.xserver = {
  enable = true;
  windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
    ];
  };
  # displayManager.defaultSession = "none+i3";
};
}
