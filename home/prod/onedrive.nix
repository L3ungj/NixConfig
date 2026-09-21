{config, lib, ...}: {
  programs.onedrive = {
    enable = true;
    settings = {
      sync_dir = "~/onedrive";
      skip_dotfiles = "true";
      skip_symlinks = "true";
    };
  };

  xdg.configFile."onedrive/sync_list".text = lib.concatLines [
    "!__pycache__/*"
    "!venv/*"

    "!node_modules/*"

    "!/cam/cstia/mlrd/*"

    "/cam/"
    "/career/"
    "/file_share/sec/"
  ];
}