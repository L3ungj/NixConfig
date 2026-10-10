{pkgs, lib, ...}: let
  langs = ["c" "cpp" "python" "nix"];
in {
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

      lua << EOF
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { ${lib.concatStringsSep ", " (map (l: ''"${l}"'') langs)} },
          callback = function(args)
            vim.treesitter.start(args.buf)
          end,
        })
      EOF
    '';
    coc = {
      enable = true;
      settings = {
        "clangd.arguments" = [
          "--query-driver=/nix/store/*/bin/gcc,/nix/store/*/bin/g++"
        ];
      };
    };
    plugins = with pkgs.vimPlugins; [
      fzf-lua
      coc-clangd
      (nvim-treesitter.withPlugins (p: map (l: p.${l}) langs))
    ];
  };
}