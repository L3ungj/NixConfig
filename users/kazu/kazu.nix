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
  ];

  home.username = "kazu";
  home.homeDirectory = "/home/kazu";

  home.packages = with pkgs; [
    fastfetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
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

    # social
    whatsapp-electron
    discord

    # apps
    musescore
    firefox
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

  home.activation.hypridle-suspend-disable = if host.name == "aether" then
    config.lib.dag.entryAfter ["copyIllogicalImpulseConfigs"] ''
      ${lib.getExe pkgs.patch} -u $HOME/.config/hypr/hypridle.conf < ${self}/hosts/aether/hypridle-suspend-disable.patch
    '' else null;

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
