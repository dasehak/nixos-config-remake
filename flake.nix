{
  description = "dasehak flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixpkgs-blender-3-6-5.url = "github:nixos/nixpkgs/a71323f68d4377d12c04a5410e214495ec598d4c";
    chaotic.url = "github:chaotic-cx/nyx";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces/main";
      inputs.hyprland.follows = "hyprland";
    };

    xdghypr = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    pollymc = {
      url = "github:fn2006/PollyMC";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yandex-music = {
      url = "github:cucumber-sp/yandex-music-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { flake-parts, ... } @ inputs:
  let
    linuxArch          = "x86_64-linux";
    stateVersion       = "24.11";

    libx = import ./lib { inherit inputs stateVersion; };
  in flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      linuxArch
    ];

    flake = {
      nixosConfigurations = {
        nyax  = libx.mkHost { hostname = "nyax"; username = "dasehak"; isWorkstation = true;  platform = linuxArch; };
        qemux = libx.mkHost { hostname = "qemux"; username = "dasehak"; isWorkstation = true;  platform = linuxArch; };
      };

      homeConfigurations = {
        "dasehak@nyax"  = libx.mkHome { hostname = "nyax";  username = "dasehak"; isWorkstation = true;  platform = linuxArch; };
        "root@nyax"     = libx.mkHome { hostname = "nyax";  username = "root";   isWorkstation = true;  platform = linuxArch; };
      };
    };
  };
}

