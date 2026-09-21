{pkgs, ...}: let
  weylusCommunityEdition = pkgs.weylus.overrideAttrs (oldAttrs: rec {
    version = "0.11.4-unstable-2026-09-21";

    src = pkgs.fetchFromGitHub {
      owner = "electronstudio";
      repo = "WeylusCommunityEdition";
      rev = "master";
      hash = "sha256-rd25QstIMC9bReDcBfT1RKlTmtMPvQtiuIJNDkVSrms=";
    };

    cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-nLspVAoEq+Ogg2/Ay0km7lD6HPNLmxQELYJ5ESiUdXU=";
    };
  });
in {
  programs.weylus = {
    enable = true;
    package = weylusCommunityEdition;
    users = ["kazu"];
  };
}