{config, ...}: let
  aliases = {
    nos = "sudo true && nh os switch .; hyrl";
    nrs = "sudo nixos-rebuild switch --flake .; hyrl";
    hyrl = "hyprctl reload";
    nfz = "nvim $(fzf)";
    ta = "tmux attach";
  };
  init = ''
    export OLLAMA_API_KEY=$(cat ${config.sops.secrets.ollama_api_key.path})
  '';
in {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
    '';

    shellAliases = aliases;
    shellInit = init;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = aliases;
    bashrcExtra = init;
  };
}
