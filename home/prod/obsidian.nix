{pkgs, ...}: {
  programs.obsidian = {
    enable = true;

    vaults.mynotes = {
      target = "onedrive/cam/cstii/mynotes";
      settings.app = {
        newLinkFormat = "absolute";
        attachmentFolderPath = "images";
        spellcheck = false;
        vimMode = true;
      };
    };

    defaultSettings = {
      communityPlugins = with pkgs.obsidianPlugins; [
        obsidian-excalidraw-plugin
      ];

      themes = with pkgs.obsidianThemes; [
        catppuccin
      ];
    };
  };
}