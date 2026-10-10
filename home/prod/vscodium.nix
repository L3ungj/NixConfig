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
  clangd = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-clangd";
      publisher = "llvm-vs-code-extensions";
      version = "0.6.0";
      hash = "sha256-hmoAPCp0BKB3z6z2Ai0w45RDE9v3BYupmu2A5y5OM50=";
    };
  };
in {
  programs.vscodium = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        james-yu.latex-workshop
        github.copilot-chat
        qt-qml
        open-remote-ssh
        clangd
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