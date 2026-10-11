{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-rime
        fcitx5-mozc
      ];
      waylandFrontend = true;
      settings = {
        inputMethod = {
          "Groups/0" = {
            Name = "main";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
          };
          "Groups/0/Items/1" = {
            Name = "rime";
          };
          "Groups/0/Items/2" = {
            Name = "mozc";
          };
          GroupOrder."0" = "main";
        };
        globalOptions = {
          "Hotkey/TriggerKeys" = {
            "0" = "Super+space";
          };
        };
      };
    };
  };
}