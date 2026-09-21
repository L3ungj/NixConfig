{
  inputs,
  ...
}: {
  imports = [
    inputs.illogical-flake.homeManagerModules.default
  ];

  programs.illogical-impulse = {
    enable = true;

    # Customize shell tools (all enabled by default)
    dotfiles = {
      fish.enable = true;     # Fish shell with custom config
      # kitty.enable = true;    # Kitty terminal emulator
      starship.enable = true; # Starship prompt
    };

    # Files here are overlaid onto ~/.config/hypr/custom after every switch
    hyprland.customDir = ./custom;
  };
}
