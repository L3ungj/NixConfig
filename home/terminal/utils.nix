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
      set number
      set relativenumber

      set expandtab
      set tabstop=2
      set shiftwidth=2
      set autoindent
      set smartindent

      set termguicolors
      set clipboard+=unnamedplus

      lua << EOF
        vim.g.mapleader = " "

        vim.keymap.set("n", "<leader>ff", function()
          require("fzf-lua").files()
        end, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", function()
          require("fzf-lua").live_grep()
        end, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", function()
          require("fzf-lua").buffers()
        end, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>fh", function()
          require("fzf-lua").help_tags()
        end, { desc = "Search help" })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = { ${lib.concatStringsSep ", " (map (l: ''"${l}"'') langs)} },
          callback = function(args)
            vim.treesitter.start(args.buf)
          end,
        })
      EOF

      lua << TERM
        vim.o.shell = "fish"

        -- https://www.reddit.com/r/vim/comments/8n5bzs/using_neovim_is_there_a_way_to_display_a_terminal/
        local term_buf
        local term_win

        local function term_toggle(height)
          if term_win and vim.api.nvim_win_is_valid(term_win) then
            vim.api.nvim_win_close(term_win, true)
            term_win = nil
            return
          end

          vim.cmd("botright " .. height .. "new")
          local new_buf = vim.api.nvim_get_current_buf()

          if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
            vim.api.nvim_win_set_buf(0, term_buf)
            vim.api.nvim_buf_delete(new_buf, { force = true })
          else
            vim.cmd("terminal")
            term_buf = vim.api.nvim_get_current_buf()
            vim.wo.number = false
            vim.wo.relativenumber = false
            vim.wo.signcolumn = "no"
          end

          term_win = vim.api.nvim_get_current_win()
          vim.cmd("startinsert")
        end

        vim.keymap.set({ "n", "t" }, "<A-t>", function()
          term_toggle(10)
        end, { desc = "Toggle terminal" })
      TERM
    '';
    coc = {
      enable = true;
      settings = {
        "clangd.arguments" = [
          "--query-driver=/home/kazu/.nix-profile/bin/c++"
        ];
      };
    };
    plugins = with pkgs.vimPlugins; [
      fzf-lua
      coc-clangd
      (nvim-treesitter.withPlugins (p: map (l: p.${l}) langs))
      mini-nvim
    ];
  };
}
