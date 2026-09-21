{inputs, pkgs, lib, config, ...}: let
  profiles = ["forge" "sage" "verve"];
  llmAgentsPkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  mnemoPkgs = inputs.mnemoflake.packages.${pkgs.stdenv.hostPlatform.system};
  hermes-mnemo = pkgs.writeShellApplication {
    name = "hermes";
    runtimeInputs = [llmAgentsPkgs.hermes-agent];
    text = ''
      export PYTHONPATH=${lib.concatStringsSep ":" [
        "${mnemoPkgs.mnemosyneAll}/lib/python3.14/site-packages"
        "${mnemoPkgs.mnemosyneHermes}/lib/python3.14/site-packages"
      ]}

      exec hermes "$@"
    '';
  };
in {
  home.packages = with llmAgentsPkgs; with mnemoPkgs; [
    hermes-mnemo
    hermes-desktop
    hermes-hud
    inputs.sageask.packages.${pkgs.stdenv.hostPlatform.system}.default
    mnemosyneAll
    mnemosyneHermes
  ] ++ map (profile: pkgs.writeShellApplication {
    name = "${profile}";
    runtimeInputs = [hermes-mnemo];
    text = ''exec hermes -p ${profile} "$@"'';
  }) profiles;

  home.file = lib.listToAttrs (
    map (profile: {
      name = ".hermes/profiles/${profile}/SOUL.md";
      value.source = ./souls/${profile}.md;
    }) profiles ++ map (profile: {
      name = ".hermes/profiles/${profile}/memories/USER.md";
      value.source = ./USER.md;
    }) profiles
  ) // {
    # WARNING: Ad-hoc fix for now, mkOutOfStoreSymlink makes secrets world-readable.
    ".local/share/sageask/.env".source = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.sageask_env.path;
  } // {
    # ln -sfn "$(~/.hermes/hermes-agent/venv/bin/python -c 'import pathlib, mnemosyne_hermes; print(pathlib.Path(mnemosyne_hermes.__file__).resolve().parent)')"/* ~/.hermes/plugins/mnemosyne/
    ".hermes/plugins/mnemosyne" = {
      source = config.lib.file.mkOutOfStoreSymlink "${mnemoPkgs.mnemosyneHermes}/lib/python3.14/site-packages/mnemosyne_hermes";
      recursive = true;
    };
  };

  # Run these imperatively to set up mnemosyne for hermes-agent for the first time.
  # hermes config set memory.provider mnemosyne
  # hermes config set memory.mnemosyne.profile_isolation true
}
