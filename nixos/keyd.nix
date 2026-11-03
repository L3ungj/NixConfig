{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          # capslock -> (held) ctrl, (tap) ESC
          capslock = "overloadt2(control, esc, 150)";
        };
      };
    };
  };
}
