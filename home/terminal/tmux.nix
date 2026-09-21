{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
    terminal = "alacritty";
    extraConfig = ''
      bind | split-window -h
      bind - split-window -v
    '';
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"

          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -agF status-right "#{E:@catppuccin_status_ram}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
        '';
      }
      cpu
      battery
    ];
  };
}