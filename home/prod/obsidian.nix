{pkgs, ...}: {
  programs.obsidian = {
    enable = true;

    vaults.mynotes.target = "onedrive/cam/cstii/mynotes";
    vaults.mynotes.settings = {
      app = {
        newLinkFormat = "absolute";
        attachmentFolderPath = "images";
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