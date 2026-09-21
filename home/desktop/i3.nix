{
  lib, 
  pkgs,
  config,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod4";  # Super/Windows key

      keybindings = lib.mkOptionDefault {
        "Mod4+Return" = "exec --no-startup-id ${pkgs.alacritty}/bin/alacritty";
      };

      startup = [
        {
          command = "${pkgs.alacritty}/bin/alacritty";
          always = true;
          notification = false;
        }
      ];

      gaps = {
        inner = 8;
        outer = 8;
      };
    };
  };
}