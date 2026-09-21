{pkgs, ...}: let
  opencui = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "opencui";
      publisher = "haoyangzeng";
      version = "1.12.1";
      hash = "sha256-2+S0D1bLJ7URIJYCNGG8sjJKoyWea1ZPkWxJ1WJuoq8=";
    };
  };
  qt-qml = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "qt-qml";
      publisher = "theqtcompany";
      version = "1.16.0";
      hash = "sha256-QWjUSbBtHIdxYZyRBDn64HXhvSwhgzm7DjDaed6lNds=";
    };
  };
  open-remote-ssh = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "open-remote-ssh";
      publisher = "jeanp413";
      version = "0.3.1";
    };
    vsix = pkgs.fetchurl {
      url = "https://open-vsx.org/api/jeanp413/open-remote-ssh/0.3.1/file/jeanp413.open-remote-ssh-0.3.1.vsix";
      hash = "sha256-xvFrIlq4aSXyvZ6Mxbox5hSXjM+hIPFQm99umeW+8T8=";
    };
  };
in {
  programs.vscodium = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        # opencui
        james-yu.latex-workshop
        github.copilot-chat
        qt-qml
        open-remote-ssh
      ];
      keybindings = [
        {
          key = "alt+shift+up";
          command = "editor.action.copyLinesUpAction";
          when = "editorTextFocus";
        }
        {
          key = "alt+shift+down";
          command = "editor.action.copyLinesDownAction";
          when = "editorTextFocus";
        }
        {
          key = "ctrl+k";
          command = "-opencui.inlineEdit";
          when = "editorTextFocus";
        }
        {
          key = "ctrl+alt+c";
          command = "copyFilePath";
        }
        {
          key = "ctrl+alt+shift+c";
          command = "copyRelativeFilePath";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    miktex
  ];
}