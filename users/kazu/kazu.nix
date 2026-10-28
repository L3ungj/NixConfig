{
  self, 
  config,
  pkgs,
  inputs,
  host,
  lib,
  ...
}: {
  imports = [
    "${self}/home/desktop"
    "${self}/home/terminal"
    "${self}/home/ai"
    "${self}/home/prod"
    inputs.sops-nix.homeManagerModules.sops
    "${self}/sops/home.nix"
    inputs.nix-index-database.homeModules.default
  ];

  home.username = "kazu";
  home.homeDirectory = "/home/kazu";

  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    bat # better `cat`
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    glow # markdown previewer in terminal

    # networking tools
    # mtr # A network diagnostic tool
    # iperf3
    # dnsutils  # `dig` + `nslookup`
    # ldns # replacement of `dig`, it provide the command `drill`
    # aria2 # A lightweight multi-protocol & multi-source command-line download utility
    # socat # replacement of openbsd-netcat
    # nmap # A utility for network discovery and security auditing
    # ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # monitoring
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    sbctl

    # C/C++ tools
    gcc
    gnumake
    cmake
    libclang

    # webdev
    bun

    # android
    android-tools
    scrcpy

    # social
    whatsapp-electron
    discord
    signal-desktop

    # apps
    musescore
    firefox
    pinta
    libreoffice
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "L3ungj";
        email = "justin.leungj@gmail.com";
      }; 
      init.defaultBranch = "main";
    };
  };

  programs.nix-index-database.comma.enable = true; 

  home.activation.hypridle-suspend-disable = lib.mkIf (host.name == "aether" || host.name == "olympus") (
    config.lib.dag.entryAfter ["copyIllogicalImpulseConfigs"] ''
      ${lib.getExe pkgs.patch} -u $HOME/.config/hypr/hypridle.conf < ${self}/hosts/aether/hypridle-suspend-disable.patch
    ''
  );

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
