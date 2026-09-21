{self, inputs, pkgs, lib, ...}: {
  services.displayManager.sddm = {
    enable = true;
    theme = "pixie";
    wayland.enable = true;

    # Crucial for Qt6
    package = lib.mkForce pkgs.kdePackages.sddm;

    # Required dependencies for Qt6 themes
    extraPackages = [
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtdeclarative
      pkgs.kdePackages.qt5compat
    ];
  };

  environment.systemPackages = [
    # Override theme with custom assets, then patch theme.conf for 24-hour clock
    (let
      customised = inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
        background = "${self}/assets/wallpapers/forest.jpg";
        avatar = "${self}/assets/avatar/me.png";
        autoColor = true;
      };
    in pkgs.runCommand "pixie-sddm-24h" {} ''
      mkdir -p $out/share/sddm/themes/pixie
      cp -r ${customised}/share/sddm/themes/pixie/* $out/share/sddm/themes/pixie/
      # Force 24-hour clock in theme.conf (prepend if not present, replace if present)
      if grep -q 'use24HourClock' $out/share/sddm/themes/pixie/theme.conf 2>/dev/null; then
        sed -i 's/use24HourClock\s*=\s*.*/use24HourClock=true/' $out/share/sddm/themes/pixie/theme.conf
      else
        echo "use24HourClock=true" >> $out/share/sddm/themes/pixie/theme.conf
      fi
    '')
  ];
}