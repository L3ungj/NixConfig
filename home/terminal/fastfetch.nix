{self, ...}: {
  # Copied from https://github.com/m90urqh/neon_miku_fastfetch
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${self}/assets/images/miku.png";
        type = "auto";
        width = 28;
      };
      
      display = {
        separator = "   ";
        color = "38;2;1;252;255";
      };
      
      modules = [
        "title"
        {
          type = "custom";
          format = "";
        }

        # ── SYSTEM ──
        {
          type = "custom";
          format = "/* SYSTEM */";
          outputColor = "38;2;225;40;133";
        }
        {
          type = "os";
          key = "  OS";
        }
        {
          type = "kernel";
          key = "  Kernel";
        }
        {
          type = "uptime";
          key = "  Uptime";
        }
        {
          type = "packages";
          key = " 󰏖 Packages";
        }
        {
          type = "custom";
          format = "";
        }

        # ── SOFTWARE ──
        {
          type = "custom";
          format = "/* SOFTWARE */";
          outputColor = "38;2;225;40;133";
        }
        {
          type = "shell";
          key = "  Shell";
        }
        {
          type = "terminal";
          key = "  Terminal";
        }
        {
          type = "custom";
          format = "";
        }

        # ── HARDWARE ──
        {
          type = "custom";
          format = "/* HARDWARE */";
          outputColor = "38;2;225;40;133";
        }
        {
          type = "host";
          key = " 󰌢 Host";
        }
        {
          type = "cpu";
          key = "  CPU";
          # format = "{name} ({cores}) @ {freq-max}";
        }
        {
          type = "gpu";
          key = " 󰢮 GPU";
        }
        {
          type = "memory";
          key = "  Memory";
        }
        {
          type = "disk";
          key = " 󰋊 Disk";
          # format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "custom";
          format = "";
        }

        # "colors"
      ];
    };
  };
}