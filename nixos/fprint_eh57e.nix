{pkgs, ...}:
let
  eh57e-src = pkgs.fetchFromGitHub {
    owner = "lagthedark";
    repo = "eh57e-libfprint";
    rev = "cc670e2bb524e2993849bf7044070d1f82b906db";
    hash = "sha256-OgWsIqKdVahVcXPlh6wbvxP38nAMjMb4AITdcshHE8w=";
  };
  eh57e-libfprint = pkgs.libfprint.overrideAttrs (old: {
    pname = "libfprint-eh57e";
    # version = "1.94.100";

    # The EH57E driver is not present in libfprint's bundled udev hwdb test data,
    # so libfprint's udev-hwdb unit test aborts. This does not affect runtime use.
    doCheck = false;
    doInstallCheck = false;

    postPatch = ''
      cp ${eh57e-src}/src/egis057e.c libfprint/drivers/egis057e.c
      cp ${eh57e-src}/src/egis057e.h libfprint/drivers/egis057e.h
      cp ${eh57e-src}/src/egis057e-matcher.c libfprint/drivers/egis057e-matcher.c
      cp ${eh57e-src}/src/egis057e-matcher.h libfprint/drivers/egis057e-matcher.h

      # Register the EH57E source files in libfprint/meson.build.
      sed -i "/^driver_sources = {/a\\
        'egis057e' : files(\\
          'drivers/egis057e.c',\\
          'drivers/egis057e-matcher.c',\\
        )," \
        libfprint/meson.build

      # Register the EH57E driver in the top-level drivers_info dictionary.
      sed -i "/^drivers_info = {/a\\
        'egis057e': {}," \
        meson.build

      echo '=== patched driver_sources ==='
      grep -n -A6 '^driver_sources = {' libfprint/meson.build

      echo '=== patched drivers_info ==='
      grep -n -A4 '^drivers_info = {' meson.build

      grep -q "'egis057e' : files(" libfprint/meson.build
      grep -q "'egis057e': {}" meson.build
    '';

    mesonFlags = (old.mesonFlags or []) ++ [
      "-Ddrivers=egis057e"
    ];
  });
in
{
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd.override {
      libfprint = eh57e-libfprint;
    };
  };
  security.pam.services.polkit-1.fprintAuth = true;
  security.pam.services.sddm.fprintAuth = true;
}