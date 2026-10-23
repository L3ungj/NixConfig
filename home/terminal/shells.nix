{config, ...}: let
  aliases = {
    nos = "sudo true && nh os switch .; hyrl";
    nrs = "sudo nixos-rebuild switch --flake .; hyrl";
    nosh = "nh os switch . --target-host";
    hyrl = "hyprctl reload";
    
    ta = "tmux attach";
    ods = "onedrive --sync";
    logout = "hyprctl dispatch 'hl.dsp.exit()'";
    
    ls = "exa --group-directories-first --icons=auto --color=auto";
    ll = "exa -l --git --header --group-directories-first --icons=auto --color=auto";
    la = "exa -la --git --header --group-directories-first --icons=auto --color=auto";
    lt = "exa --tree --level=2 --group-directories-first --icons=auto --color=auto";
  };
  # init = ''
  #   export OLLAMA_API_KEY=$(cat ${config.sops.secrets.ollama_api_key.path})
  # '';
in {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
    '';

    shellAliases = aliases;
    # shellInit = init;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = aliases;
    # bashrcExtra = init;
  };
}
