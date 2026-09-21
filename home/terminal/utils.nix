{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set expandtab
      set tabstop=2
      set shiftwidth=2
    '';
  };
}