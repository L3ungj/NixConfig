{pkgs, ...}: {
  programs.obsidian = {
    enable = true;

    vaults.mynotes.target = "onedrive/cam/cstii/mynotes";

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