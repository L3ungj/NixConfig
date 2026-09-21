{
  config, pkgs, ...
}: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = {
          x = 16;
          y = 16;
        };
        decorations = "full";
        dynamic_title = true;
        dynamic_padding = true;
        opacity = 0.95;
      };

      # Font
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 11.0;
      };

      # Colors (example: Tokyo Night)
      colors = {
        primary = {
          background = "#1a1b26";
          foreground = "#a9b1d6";
        };
        cursor = {
          text = "#1a1b26";
          cursor = "#c0caf5";
        };
        normal = {
          black = "#15161e";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };
        bright = {
          black = "#414868";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#c0caf5";
        };
      };

      # Cursor
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
      };
    };
  };
}