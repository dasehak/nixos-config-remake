{
  description = "dasehak flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    nixpkgs-blender-3-6-5.url = "github:nixos/nixpkgs/a71323f68d4377d12c04a5410e214495ec598d4c";
    nixpkgs-materialgram.url = "github:nixos/nixpkgs/2b58bfe2c0d73341362870a0f1e50b2b8f2e4b84";
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
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    fps = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    ayugram-desktop.url = "git+https://github.com/kaeeraa/ayugram-desktop?submodules=1";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    catppuccin.url = "github:catppuccin/nix";

    openbonzi.url = "git+https://codeberg.org/ext0l/openbonzi";
  };

  outputs = { flake-parts, ... } @ inputs:
    let
      linuxArch = "x86_64-linux";
      stateVersion = "24.11";

      libx = import ./lib { inherit inputs stateVersion; };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        linuxArch
      ];

      flake = {
        nixosConfigurations = {
          nyax = libx.mkHost { hostname = "nyax"; username = "dasehak"; isWorkstation = true; platform = linuxArch; };
          qemux = libx.mkHost { hostname = "qemux"; username = "dasehak"; isWorkstation = true; platform = linuxArch; };
        };

        homeConfigurations = {
          "dasehak@nyax" = libx.mkHome { hostname = "nyax"; username = "dasehak"; isWorkstation = true; platform = linuxArch; };
          "root@nyax" = libx.mkHome { hostname = "nyax"; username = "root"; isWorkstation = true; platform = linuxArch; };

          "dasehak@qemux" = libx.mkHome { hostname = "qemux"; username = "dasehak"; isWorkstation = true; platform = linuxArch; };
          "root@qemux" = libx.mkHome { hostname = "qemux"; username = "root"; isWorkstation = true; platform = linuxArch; };
        };
      };
    };
}

