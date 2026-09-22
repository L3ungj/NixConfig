{
  description = "NixOS configuration of Justin Leung";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lan-mouse.url = "github:feschber/lan-mouse";
    dots-hyprland = {
      url = "git+https://github.com/L3ungj/dots-hyprland?submodules=1";
      # url = "path:/home/kazu/nix/dots-hyprland";
      flake = false;
    };
    illogical-flake = {
      url = "github:L3ungj/illogical-flake";
      # url = "path:/home/kazu/nix/illogical-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dotfiles.follows = "dots-hyprland";
    };
    pixie-sddm.url = "github:xCaptaiN09/pixie-sddm";
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sageask = {
      url = "github:L3ungj/sageask";
      # url = "path:/home/kazu/dev/sageask";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mnemoflake = {
      url = "github:L3ungj/mnemoflake";
      # url = "path:/home/kazu/dev/mnemoflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # nixConfig = {
  #   extra-substituters = [
  #     "https://nixos-raspberrypi.cachix.org"
  #   ];
  #   extra-trusted-public-keys = [
  #     "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
  #   ];
  # };

  outputs = inputs @ {
    self,
    nixpkgs,
    sops-nix,
    home-manager,
    ...
  }: let
    specialArgs = { 
      inherit self;
      inherit inputs;
      inherit keys;
    };
    hosts = [
      {
        name = "sapin";
        users = ["kazu"];
        system = "x86_64-linux";
        type = "pc";
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8+3vijn/CdsrJFKI/g0vXB35+4qxUazVj8DSicSGRo kazu@sapin"
        ];
      }
      {
        name = "aether";
        users = ["kazu"];
        system = "x86_64-linux";
        type = "pc";
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPXu7AZuXtVcEe2WALeOE5pViSLNGHJVjATetwvfQESZ kazu@aether"
        ];
      }
      {
        name = "olympus";
        users = ["kazu"];
        system = "x86_64-linux";
        type = "pc";
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWGN0gtWUNEDyUoeEXbjHSE8dLEFsbMJudf/jYEcVx7 kazu@nixos"
 	];
      }
      {
        name = "radon";
        users = ["tiny"];
        system = "aarch64-linux";
        type = "rpi5";
        keys = [];
      }
      {
        name = "phone";
        keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILGCfE6UMJ34QH/YOaXch/UP1BbqXkk8Q1vXWRHFjdkF Ed25519"];
      }
    ];
    keys = nixpkgs.lib.concatMap (host: host.keys) hosts;
    getUserModules = map (user: ./users/${user}/nixos.nix);
  in {
    nixosConfigurations = builtins.listToAttrs (map (host: let
      specialArgsWithHost = specialArgs // {inherit host;};
      in {
      name = host.name;
      value = if host.type == "pc" then nixpkgs.lib.nixosSystem {
        system = host.system;
        specialArgs = specialArgsWithHost;
        modules = [
          sops-nix.nixosModules.sops
          ./hosts/${host.name}/${host.name}.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "bak";

            home-manager.users = builtins.listToAttrs (map (user: {
              name = user;
              value = import ./users/${user}/${user}.nix;
            }) host.users);
            home-manager.extraSpecialArgs = specialArgsWithHost;
          }
        ] ++ (getUserModules host.users);
      } else if host.type == "rpi5" then inputs.nixos-raspberrypi.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/${host.name}/${host.name}.nix
        ] ++ (getUserModules host.users);
      } else {};
    }) hosts);
    homeConfigurations = builtins.listToAttrs (map (user: {
      name = user;
      value = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs;
        extraSpecialArgs = specialArgs;
        modules = [
          sops-nix.homeManagerModules.sops
          ./users/${user}/${user}.nix
        ];
      };
    }) ["kazu" "tiny"]);
  };
}
